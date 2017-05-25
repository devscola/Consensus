# INDEX

* Configure local system
* Docker
* How to dockerize system
* Continuous Integration: Travis-CI
* Consensus BEM convention for style sheet


# CONFIGURE LOCAL SYSTEM

## Preconfiguration of linux systems at no dockerized environment

Very slow install of latest ruby with rbenv and after compile it:
~~~
sudo apt-get install build-essential
sudo apt-get install libssl-dev libreadline-dev zlib1g-dev
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
source ~/.bash_profile
rbenv install 2.4.0
rbenv global 2.4.0
ruby --version
~~~

Or, fast install of Ruby (not latest version), Ruby-dev and Ruby-rack:
~~~
sudo apt-get install ruby ruby-dev ruby-rack
~~~

After, visit nokogiri page ( http://www.nokogiri.org/tutorials/installing_nokogiri.html ) and install dependencies, in debian/ubuntu:

~~~
sudo apt-get install build-essential
sudo apt-get install patch zlib1g-dev liblzma-dev libxslt-dev libxml2-dev
~~~

For web-test install chromedriver (webdriver):

~~~
sudo apt-get install chromium-chromedriver
~~~

or manually install:

~~~
wget https://chromedriver.storage.googleapis.com/2.29/chromedriver_linux64.zip
sudo unzip -e chromedriver_linux64.zip -d /usr/local/bin/;
~~~

or install from pip:

~~~
sudo apt install python-pip python-dev build-essential
pip install --upgrade pip
pip install chromedriver
~~~

## Install gems manually

If you want to manually install the gems, open the Gemfile and install all gems.


## Install gems with bundler

You can choose if install the gems in your system or only in the project folder.

For automation system gem installation use:
~~~
sudo apt-get install ruby-bundler
~~~

or
~~~
gem install bundler
~~~

For installing the gems in the project folder use:
~~~
bundle install --path vendor/bundle
~~~


## Install MongoDB

Link: https://www.mongodb.com/


## Run tests in local environment:

First start MongoDB.

To run the test you must have the Consensus app up.

Prepare the local project:

~~~
bundle exec rake prepare
sh buildMongoLocal.sh
~~~

then run Rake:

~~~
bundle exec rake
~~~

That will raise the Consensus web in your localhost:4567

Then in other terminal you can run the tests with:

All the tests:

~~~
bundle exec rake test
~~~

The unitarian spec tests:

~~~
bundle exec rake tdd
~~~

The behauvior spec tests:

~~~
bundle exec rake bdd
~~~

To run specific test you can do it like this:

~~~
bundle exec rspec -e 'any word of the test title'
~~~

### To tag a test and run only tagged tests

**1.** To tag a specific test, we have to write after the test name the tag that we want to use, with a comma and the _:tag_name_ as follows:

~~~
it 'test_name', :some_example_tag do
   _Arrange_
   _Add_
   _Assert_
 end
~~~

In this case,  _some_example_tag_ is the tag that we are using.

**2.** To run the specific test with this tag, you can do it this way:

~~~
bundle exec rake tag[some_example_tag]
~~~

## Bootstrap

Link: http://getbootstrap.com


## To tag tests and run it

We must do this to be able to add a tag in the tests and be able to run them individually:


**1.** In the _Rakefile_ we add this code:

~~~
require 'rspec/core/rake_task'
~~~

And after that:

~~~
desc 'Run tagged tests'
 RSpec::Core::RakeTask.new do |test, args|
 test.pattern = Dir['spec/**/*_spec.rb']
 test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
~~~

The first line is the description of the code, inside the inverted commas we write the description.
In the second one, we call to the function with _rspec_ and say to it that we are going to use the arguments that hereinafter we will work across the _tag_.
In the third one, we specify the tests path.
In the fourth one, we make a method to use the _tag_ tag. (we can use any word to tag)

**2.** In the test files  _test_name_spec.rb_ we add the tag. To make it possible, we have to write after the test name the tag that we want to use, with a comma and the _:tag_name_ as follows:

~~~
it 'test_name', :example do
   Arrange
   Act
   Assert
 end
~~~

In this case,  _example_ is the tag that we are using.

With this, we could run the tests this way:

~~~
rspec --tag example
~~~

**3.** To run the tag test with _rake_, we must add this code to the _"Rakefile"_:

~~~
task :tag, [:tag] do |t, arg|
 sh "rspec --tag #{arg.tag}"
end
~~~

This code adds one _task_ inside the _Rakefile_. The task makes possible that could be thrown with _rake_ when you add a tag in a test.
You can add the same tag in different tests.

Our  _Rakefile_ will be like this:

~~~
require 'rspec/core/rake_task'

task :tag, [:tag] do |t, arg|
  sh "rspec --tag #{arg.tag}"
end

desc 'Run labeled tests'
  RSpec::Core::RakeTask.new do |test, args|
  test.pattern = Dir['spec/**/*_spec.rb']
  test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
~~~

In this moment, we could run the tests this way:

~~~
rake tag[example]
~~~

# DOCKER

## A. DOCKER INSTALATION:

1.- You must install Docker following the web instructions:

Link: www.docker.com

2.- You must follow the steps in the docker web to be familiar with.

3.- Also follow the instructions 'Post-installation steps for Linux'.

4.- It's important to clean your docker images and containers when you are goin to start with docker.

5. Install docker-compose.

Link: https://docs.docker.com/compose/install/

6. If you are user Windows remember share your C: drive in docker settings.


##  B. RUN DOCKER

1.- Download git:

~~~
git clone https://github.com/devscola/consensus
~~~

Start the docker-compose service to be able to run the test:

~~~
docker pull devscola/consensus:latest
docker-compose build
~~~

In one console, up the docker container, in other console run the tests:

Console A:

~~~
docker-compose up
~~~

Console B:

All test:

~~~
docker-compose run web rake test
~~~

The unitarian spec tests:

~~~
docker-compose run web rake tdd
~~~

The behavior spec tests:

~~~
docker-compose run web rake bdd
~~~

To run specific test you can do it like this:

docker-compose run web rspec -e  'any word of the test title'

To run a specific test with a tag, you can do it this way:

~~~
docker-compose run web rake tag[example]
~~~

In this case,  _example_ is the tag that we are using.


##C. QUICK SUMMARY OF DOCKER CHEAT SHEET

We are going to have docker images and docker containers, they are different.

For list images:

~~~
docker <image>
~~~

To run a container:

~~~
docker run [options]
~~~

Delete a image:

~~~
docker rmi <image>
~~~

If you can't delete a image is because it has not a tag. You should look your IMAGE ID to write it:

~~~
docker rmi <image_tag>
~~~

If de system don't allow you to delete it, is because you have to stop the container:

~~~
docker rmi <image> --force
~~~

View the containers:

~~~
docker ps -a
~~~

Delete a container:

~~~
docker rm <whalesay>
~~~

Delete all containers:

~~~
docker rm $(docker ps -a -q)
~~~

If it doesn't work, we can add -f (force):

~~~
docker rm -f $(docker ps -a -q)
~~~

Delete all images:

docker rmi -f $(docker images -q)

Every time that we make exit in our docker, we have to delete the container and we have to run again.

~~~
docker rm <container_name>
~~~




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

RUN mkdir -p /opt/consensus
ADD . /opt/consensus
WORKDIR /opt/consensus

ENV CONSENSUS_MODE development

RUN apt-get update
RUN gem install bundler
RUN bundle install
~~~

Lines 3 to 5 share git directori to docker system.

Line 7 sets the environment variable 'CONSENSUS_MODE' in the Docker environment. When creating this variable in the Docker environment we make sure that it does not exist in the local environment and we can decide if 'rake' is running on a Docker environment or a local environment.

Line 9 to 11 update Docker system and install 'bundler' to be used by the Docker environment. It would be wise to check that the Gemfile configuration is correct.

## Preparation a image of docker build

Build the image:
~~~
docker build -t consensus .
~~~

List image created:
~~~
docker images
~~~

Create tag of the build:
~~~
docker tag 7d9495d03763 devscola/consensus:latest
~~~

Confirm has docker image has been tagged:
~~~
docker images
~~~

Log-in in Docker:
~~~
docker login
~~~

Push image:
~~~
docker push devscola/consensus:latest
~~~


## Preparation of Docker-compose

We create the file 'docker-compose.yml' with the following content:

~~~
version: '2'
services:
  image: devscola/consensus:latest
  web:
    container_name: consensus
    build: .
    ports:
      - ${SINATRA_DEFAULT_PORT}:${SINATRA_DEFAULT_PORT}
    volumes:
     - .:/opt/consensus
     - bundle:/usr/local/bundle
    links:
      - selenium
      - mongocontainer
    command: bundle exec rake

  selenium:
    image: selenium/standalone-chrome
    ports:
        - "4444:4444"
    container_name: chrome-browser
    logging:
      driver: none

  mongocontainer:
    image: mongo:latest
    ports:
        - "27017:27017"
    command: --smallfiles

volumes:
  bundle:
    driver: local
~~~

In line 8, the environment variable is read for the port that the container will use.

The first parameter refers to the input (exposed by Sinatra) and the second parameter refers to the output port of the container for that service.

In line 13 we are forced to put into the Selenium environment that will be in charge of giving the web service that we need, and in line 14 on put link to Mongo container.

On line 15, we tell our container to start the indicated 'bundle' at the start of the environment.

## Preparing the application for booting with 'rake'

We need the 'rake' to pick up the application both locally and in the Docker environment.

To do this we must adapt our application so that 'rake' can handle it.

In the app.rb we change the 'require sinatra' to 'require sinatra/base'.

Next we create an App class:

~~~
class App < Sinatra::base

  [... content app...]

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
require_relative 'environment_configuration'
require 'rspec/core/rake_task'
require 'mongoid'

SINATRA_PORT = retrieve_port

TRAVIS = retrieve_travis

task :default => :start

task :start do
  sh 'mkdir public/vendor/polymer -p'
  Support::Courier.act

  if ( TRAVIS == false )
    sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0"
  end
  if ( TRAVIS == true )
    File.delete('travis.ci')
	  sh "rerun --background -- rackup --port #{SINATRA_PORT} -o 0.0.0.0 &"
    sh 'rspec spec/tdd'
    sh 'rspec spec/bdd'
  end
end

task :tdd do
  sh 'rspec spec/tdd'
end

task :bdd do
  sh 'rspec spec/bdd'
end

task :test => [:tdd, :bdd] do
end

task :tag, [:tag] do |t, arg|
  sh "rspec --tag #{arg.tag}"
end

desc 'Run labeled tests'
  RSpec::Core::RakeTask.new do |test, args|
  test.pattern = Dir['spec/**/*_spec.rb']
  test.rspec_opts = args.extras.map { |tag| "--tag #{tag}" }
end
~~~

In it we read the variable of the file '.env' and keep it as constant (necessary) to launch the rake (line 16 and 20).

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
require_relative '../environment_configuration'

SINATRA_PORT = retrieve_port

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

## Environment configuration

The file 'environment_configuration.rb':

~~~
def retrieve_mode
  begin
    consensus_environment = ENV.fetch('CONSENSUS_MODE')
  rescue
    consensus_environment = nil
  end
  return consensus_environment
end

def retrieve_port
  begin
    capybara_default_port =  eval File.open('.env').read
  rescue
    capybara_default_port = '4567'
  end
  return capybara_default_port
end

def retrieve_travis
   File.exist?('travis.ci')
end
~~~

In this file on create the functions for configure the diferents environments.

The file 'mongoid.yml':

~~~
development:
  clients:
    default:
      database: consensus_db
      hosts:
        - localhost:27017
~~~

The file 'support/configuration.rb'

~~~
Mongo::Logger.logger.level = ::Logger::INFO

module Support
  class Configuration
    HOSTS = {
      'development' => 'mongocontainer',
      nil => 'localhost'
    }

    def self.retrieve_mode
      begin
        consensus_environment = ENV.fetch('CONSENSUS_MODE')
      rescue
        consensus_environment = nil
      end
      return consensus_environment
    end

    def self.host
      HOSTS[retrieve_mode]
    end
  end
end
~~~

And in the repository's files on add:

~~~
require 'mongo'

def connection
  @connection ||= Mongo::Client.new(
    ["#{host}:27017"],
    :database => 'consensus_db'
  )
end

def host
  Support::Configuration.host
end
~~~


# CONTINUOUS INTEGRATION

## Travis-ci.org

Link: https://docs.travis-ci.com/user/getting-started/

Create the archive '.travis.yml' in git repository:

~~~
sudo: required

env:
  DOCKER_COMPOSE_VERSION: 1.11.2

services:
  - docker

before_install:
  - sudo rm /usr/local/bin/docker-compose
  - curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > docker-compose
  - chmod +x docker-compose
  - sudo mv docker-compose /usr/local/bin

install:
  - docker pull devscola/consensus:latest
  - docker-compose build
  - docker-compose up -d
  - sleep 5

script:
  - docker-compose run web /bin/sh -c "cd /opt/consensus; touch travis.ci; bundle install; bundle exec rake"
  - sleep 1

after_script:
  - docker-compose down

notifications:
  slack:
    template:
      - "Build <%{build_url}|#%{build_number}> (<%{compare_url}|%{commit}>) of %{repository}@%{branch} by %{author} %{result} in %{duration}"
    rooms:
      - devscola:l7PXPT2ycwSwtbwNI8Bd1hEb#run2017
~~~

The first hack is to convert travis execution in an unique format, and difference it from others types of execution (local, docker, ...).

In travis-ci it's necessary to create a rutine for only one console use. For that it's necessary use docker-compose up by '-d' option to leave the process running and continue the run rutine.

After that we would run the test, but in docker we have also to run the test behauvoir. The problem is that system variables of travis-machine do not move to docker container. For that reason, it's necessary to create a interaction in the system for recognise a local system or a travis system in docker.

We can do that using a hack to create a file only in travis environment ('touch travis.ci' in script) and looking for that in Rakefile. If that file we have the delete command to the file 'travis.ci' and after that it execute the code necessary for travis environment.

In the code of Rakefile I added the '&' on rake to leave this in background and run inmediately the test.

# Consensus BEM convention for style sheet

## Exemples:

### Naming blocks

* two word: `class="block-name"`
* one word: `class="person"`

### Naming Block parts

* `class="block-name__part"`
* `class="person__hand"`

### Naming Block Modifier

* `class="block-name--modifier-name"`
* `class="block--modifier"`
* `class="person--female"`

### Naming Block Part Modifier

* `class="block-name__part-name--modifier-name"`
* `class="block__part--modifier"`
* `class="person__hand--open"`
* `class="person__hair--dark-red"`

### Nesting

```html
<div class="block">
    <div class="block__elem1">
        <div class="block__elem2">
            <div class="block__elem3"></div>
        </div>
    </div>
</div>
```

The block structure is always represented as a flat list of elements in the BEM methodology:

```css
.block {}
.block__elem1 {}
.block__elem2 {}
.block__elem3 {}
```

## Rules:

* It's forbiden to create a part inside a block part.
```html

<!-- wrong: -->
class="person__hand__finger"
<!--        -->

<!-- right: -->
class="person__finger"
<!--        -->

```
* A modifier is always a modifier of a block or of a block-part: "In the BEM methodology, a modifier cannot be used outside of the context of its owner."

```html

<!-- wrong: -->
class="block-name modifier-name"
class="person move-forward"
<!--        -->

<!-- right: -->
class="block-name__part-name--modifier-name"
class="person__hand--open"
class="person--walking"
<!--        -->

```
