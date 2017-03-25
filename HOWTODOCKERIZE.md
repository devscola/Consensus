#HOW TO DOCKERIZE SYSTEM

##Preámbulo

Para crear un entorno unificado en todos los puestos de trabajo utilizaremos Docker. Docker nos permite tener en nuestro sistema las mismas versiones y dependencias que necesitamos para el proyecto independientemente de la configuración y sistema operativo de cada equipo.

Para tener un entorno Docker flexible necesitaremos configurar el archivo 'Dockerfile' donde especificaremos un directorio donde anclar los ficheros y unas especificaciones mínimas de los componentes necesarios (programas, directorios compartidos, gemas, ...).

Para mejorar la utilidad de Docker utilizaremos Docker-compose que nos permite unir diferentes imágenes Docker y relacionarlas para que trabajen en conjunto. Para ello deberemos configurarlas a través del archivo 'docker-compose.yml'.

##Las variables de entorno

El uso de variables en un entorno Docker tiene sus peculiaridades.

Si realmente queremos que el uso de variables nos permita tener un entorno sano deberemos configurarltas a través de un archivo que nos permita reunirlas y configurarlas una sola vez y en un solo sitio.

Sin embargo el sistema Docker no fue diseñado para trasladar el sistema anfitrión a la imagen Docker, sino todo lo contrario.

Para lidiar con esta peculiaridad deberemos crear un archivo de configuración para las variables de entorno.

Si las variables de entorno no están definidas en mayúsculas no serán interpretadas correctamente por a través de 'Rakefile', 'docker-compose.yml' y 'spec_helper_bdd.rb'.

La variable de entorno bash ocasiona un mensaje de aviso si se utiliza tanto en el entorno local como a través de 'Rakefile' y 'spec_helper_bdd.rb'.

Ello nos obliga a no utilizar el mismo nombre cuando leemos la variable de entorno y la aplicamos a través de los archivos de configuración 'Rakefile' y 'spec_helper_bdd.rb'.

El archivo donde debemos guardar las variables de entorno debe ser '.env' (archivo oculto), el cual no puede cambiar de nombre para que pueda ser leído para la configuración de 'docker-compose.yml'.

Como último requisito debemos mantener la configuración de test para aquellos ordenadores o sistemas operativos que no puedan instalar Docker. Esto nos obligará a saber si estamos arrancando los test desde un entorno Docker o un entorno local.

Si todo esto parecía poco, por defecto tenemos en el '.gitignore' el archivo '.env', por lo que deberemos eliminarlo para poder subirlo al repositorio o forzar su inclusión.


##Preparación del archivo de variables de entorno '.env'

Debemos crear el archivo '.env' con el siguiente contenido:

~~~
SINATRA_DEFAULT_PORT=4567
~~~

Después, si no queremos eliminarlo del '.gitignore' deberemos forzar su inclusión:

~~~
git add .env -f
~~~

Utilizaremos mayúsculas no solo por claridad y convención de Bash, sino porque de otra forma en ciertos puntos la variable no será reconocida.


##Preparación del Docker

Creamos el archivo 'Dockerfile':

~~~
FROM ruby:2.4.0

CMD . /opt/consensus
ENV .env /opt/consensus
CMD /bin/bash env .env

ENV app /opt/consensus
ENV CONSENSUS_MODE development
RUN mkdir -p $app
RUN apt-get update
RUN apt-get install g++
RUN apt-get install make
RUN gem install bundler
WORKDIR $app
~~~

Las líneas 4 y 5 son las encargadas de recoger las variables de entorno y aplicarlas al entorno Docker.

La línea 8 establece la variable de entorno 'CONSENSUS_MODE' en el entorno Docker. Al crear esta variable en el entorno Docker nos aseguramos que no existe en el entorno local y podemos dirimir si 'rake' se está ejecutando sobre un entorno Docker o un entorno local.

La línea 13 instala 'bundler' para ser utilizado en el entorno Docker. Sería conveniente revisar que la configuración de Gemfile es la correcta.


##Preparación de Docker-compose

Creamos el archiov 'docker-compose.yml' con el siguiente contenido:

~~~
version: '2'
services:
  app:
    build: .
    ports:
      - ${SINATRA_DEFAULT_PORT}:${SINATRA_DEFAULT_PORT}
    volumes:
      - .:/opt/consensus
      - bundle:/usr/local/bundle
    links:
      - selenium
    command: bash -c  "bundle install --jobs 3 && bundle exec rake"

  selenium:
    image: selenium/standalone-chrome
    ports:
       - "4444:4444"
    container_name: chrome-browser
    logging:
      driver: none

volumes:
  bundle:
    driver: local
~~~

En la línea 6 se realiza la lectura de la variable de entorno para el puerto que utilizará el contenedor.

El primer parámetro se refiere a la entrada (expuesto por Sinatra) y el segundo parámetro se refiere al puerto de salida del contenedor para dicho servicio.

En la línea 11 obligamos a poner en funcionamiento el entorno Selenium que se encargará de dar el servicio web que necesitamos.

En la línea 12 le indicamos a nuestro contenedor que deberá arrancar el 'bundle' indicado al iniciar el entorno.


##Preparación de la aplicación para arrancar con 'rake'

Necesitamos que el 'rake' pueda levantar la aplicación tanto en local como en el entorno Docker.

Para ello debemos adaptar nuestra aplicación para que 'rake' pueda manejarla.

En la app.rb cambiamos el 'require sinatra' por 'require sinatra/base'.

A continuación creamos una clase App:

~~~
class App < Sinatra::base

  [... contenido de la app...]

end
~~~

Esta clase define los métodos de clase (get, post, before, configure, set, etc.) permitiendo el funcionamiento del Sinatra en background.

Creamos el archivo 'config.ru' necesario para que 'rake' localice y ejecute nuestra aplicación:

~~~
require_relative "app.rb"

run App.new
~~~

Como punto final actualizamos el 'Rakefile' con el siguiente contenido:

~~~
def retrieve_port
  begin
    capybara_default_port =  eval File.open('.env').read
  rescue
    capybara_default_port = '4567'
  end
  return capybara_default_port
end

SINATRA_PORT = retrieve_port

task :default => :start

task :start do
  sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0"
end

task :tdd do
  sh 'rspec spec/tdd'
end

task :bdd do
  sh 'rspec spec/bdd'
end

task :test => [:tdd, :bdd] do
end
~~~

En él leemos la variable del archivo '.env' y la guardamos como constante (necesario) para lanzar el rake (línea 15).

'Rerun' permite que la web se actualice con cada cambio sin la necesidad de parar y volver a arrancar sinatra.

'Background' permite que el navegador se ejecute en segundo plano para evitar que al cargar los test se abra el chrome.

'Rackup' es la orden de ejecución, 'port' es el puerto del Sinatra y '-o' define el origen, en este caso 0.0.0.0 (localhost).

Esta línea levanta el archivo de configuración rackup. Su archivo de configuración es config.ru.


##Preparación de la configuración de los test

Debemos actualizar el archivo 'spec_helper_bdd.rb' con el siguiente contenido:

~~~
require 'sinatra'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'

def retrieve_port
  begin
    capybara_default_port =  eval File.open('.env').read
  rescue
    capybara_default_port = '4567'
  end
  return capybara_default_port
end

SINATRA_PORT = retrieve_port

def retrieve_mode
  begin
    consensus_environment = ENV.fetch('CONSENSUS_MODE')
  rescue
    consensus_environment = nil
  end
  return consensus_environment
end

def host_ip
  routes = `/sbin/ip route`
  routes.match(/[\d\.]+/)
end

def use_selenium
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, {
      browser: :remote,
      url: 'http://chrome-browser:4444/wd/hub',
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome
    })
  end
  Capybara.default_driver = :chrome
  Capybara.app_host = "http://#{host_ip}:#{SINATRA_PORT}"
end

def use_chrome
  Capybara.register_driver :chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  Capybara.default_driver = :chrome
  Capybara.app_host = "http://localhost:#{SINATRA_PORT}"
end

mode = retrieve_mode

if (mode == 'development')
  use_selenium
else
  use_chrome
end
~~~

Con la función 'retrieve_port' leemos la variable del archivo '.env' y posteriormente la guardamos como constante (necesario).

Con la función 'retrieve_mode' leemos la constante creada en el contenedor y la guardamos como 'CONSENSUS_MODE'.

Con la función 'host_ip' localizamos la IP que nos ha sido asignada, la cual es variable y depende del entorno.

Con la función 'use_selenium' configuramos las características del servidor selenium para poder ser utilizado en el entorno docker.

Con la función 'use_chrome' configuramos las características para utilizar el chrome local.

Finalmente con el 'if', y gracias a tener la variable 'CONSENSUS_MODE' definida solo en el entorno docker, podemos decidir si nuestro entorno utiliza selenium o chrome.
