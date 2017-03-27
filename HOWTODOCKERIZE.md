#HOW TO DOCKERIZE SYSTEM

##Preamble

To create a unified environment in all computers, we use Docker. Docker allows us to have in our system the same versions and dependencies that we need for the project regardless of the configuration and operating system of each team.

In order to have a Flexible Docker environment we will need to configure the 'Dockerfile' file where we will specify a directory to anchor the files and a minimum specification of the necessary components (programs, shared directories, gems, ...).

To improve the utility of Docker we will use Docker-compose that allows us to join different Docker images and link them to work together. For this we must configure them through the file 'docker-compose.yml'.

##Environment variables

The use of variables in a Docker environment has its peculiarities.

If we really want that the use of variables allows us to have a healthy environment we must configure them through a file that allows us to gather them and configure them once and in one place.

However the Docker system was not designed to move the host system to the Docker image, quite the opposite.

To deal with this peculiarity we must create a configuration file for the environment variables.

If the environment variables are not defined in uppercase they will not be interpreted correctly through 'Rakefile', 'docker-compose.yml' and 'spec_helper_bdd.rb'.

The environment variable causes a warning message if it is used in the local environment and through 'Rakefile' and 'spec_helper_bdd.rb'.

This forces us not to use the same name when we read the environment variable and apply it through the configuration files 'Rakefile' and 'spec_helper_bdd.rb'.

The file where we should save the environment variables must be '.env' (hidden file), which can not be renamed because in that case it could be read for the 'docker-compose.yml' configuration.

As a last requirement, we must maintain the test configuration for those computers or operating systems that can not be installed by Docker. This will force us to know if we are starting the tests from a Docker environment or a local environment.

If all this seemed little, by default we have the '.gitignore' file '.env', so we must remove it to be able to upload it to the repository or force its inclusion.


##Preparing the environment variables file '.env'

We must create the file '.env' with the following content:

~~~
SINATRA_DEFAULT_PORT = 4567
~~~

Then, if we do not want to eliminate it from '.gitignore' we should force its inclusion:

~~~
git add .env -f
~~~

We use capitalization not only for clarity and convention of Bash, also because in certain points the variable will not be recognized.


##Preparing the Docker

Create the file 'Dockerfile':

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

Lines 4 and 5 are responsible for collecting environment variables and applying them to the Docker environment.

Line 8 sets the environment variable 'CONSENSUS_MODE' in the Docker environment. When creating this variable in the Docker environment we make sure that it does not exist in the local environment and we can decide if 'rake' is running on a Docker environment or a local environment.

Line 13 installs 'bundler' to be used by the Docker environment. It would be wise to check that the Gemfile configuration is correct.


##Preparation of Docker-compose

We create the file 'docker-compose.yml' with the following content:

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

In line 6, the environment variable is read for the port that the container will use.

The first parameter refers to the input (exposed by Sinatra) and the second parameter refers to the output port of the container for that service.

In line 11 we are forced to put into the Selenium environment that will be in charge of giving the web service that we need.

On line 12, we tell our container to start the indicated 'bundle' at the start of the environment.

## Preparing the application for booting with 'rake'

We need the 'rake' to pick up the application both locally and in the Docker environment.

To do this we must adapt our application so that 'rake' can handle it.

In the app.rb we change the 'require sinatra' to 'require sinatra/base'.

Next we create an App class:

~~~
class App < Sinatra::base

  [... contenido de la app...]

end
~~~

This class defines the class methods (get, post, before, configure, set, etc.) allowing the Sinatra to work in the background.

We create the file 'config.ru' necessary for 'rake' to locate and run our application:

~~~
require_relative "app.rb"

run App.new
~~~

At last we update the 'Rakefile' with the following content:

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

In it we read the variable of the file '.env' and keep it as constant (necessary) to launch the rake (line 15).

'Rerun' allows the web to be updated with every change without the need to stop and restart sinatra.

'Background' allows the browser to run in the background to prevent the chrome being opened when loading the tests.

'Rackup' is the execution order, 'port' is the Sinatra port and '-o' defines the origin, in this case 0.0.0.0 (localhost).

This line raises the rackup configuration file. Your configuration file is config.ru.

Ruby's who interprets this file and after having read the variable file '.env' we must have the following in mind:

A. We can not read the environment variable if it is in lower case.

B. We can not directly apply the function that reads the variable because it is lowercase

C. The environment variable that is read from '.env' must be in upper case, this implies that it is interpreted as a constant in Ruby.

D. When reading it as a constant we can not reuse its name, so we must give it another name before we can use it.

##Preparation of test configuration

We need to update the file 'spec_helper_bdd.rb' with the following content:

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

With the function 'retrieve_port' we read the variable of the file '.env' and then it is interpretated as constant (necessary).

Ruby's who interprets this file and after having read the variable file '.env' we must have the following in mind:

A. We can not read the environment variable if it is in lower case.

B. We can not directly apply the function that reads the variable because it is lowercase

C. The environment variable that is read from '.env' must be in upper case, this implies that it is interpreted as a constant in Ruby.

D. When reading it as a constant we can not reuse its name, so we must give it another name before we can use it.

With the 'retrieve_mode' function, we read the constant created in the container and save it as 'CONSENSUS_MODE'.

With the function 'host_ip' we locate the IP that has been assigned to us, which is variable and depends on the environment.

With the 'use_selenium' function we configure the features of the selenium server to be used in the docker environment.

With the 'use_chrome' function we configure the features to use the local chrome.

Finally with 'if', and thanks to having the variable 'CONSENSUS_MODE' defined only in the docker environment, we can decide if our environment uses selenium or chrome.
