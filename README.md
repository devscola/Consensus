# Consensus

## Preconfiguration of linux systems

Install Ruby, Ruby-dev and Ruby-rack:

~~~
sudo apt-get install ruby ruby-dev ruby-rack
~~~

Visit nokogiri page ( http://www.nokogiri.org/tutorials/installing_nokogiri.html ) and install dependencies, in debian/ubuntu:

~~~
sudo apt-get install build-essential patch
sudo apt-get install zlib1g-dev liblzma-dev libxslt-dev libxml2-dev
~~~

For web-test install chromedriver (webdriver):

~~~
sudo apt-get install chromium-chromedriver
~~~



## Install gems


*Bundler* gem has to be installed first:

~~~
sudo gem install bundler
~~~

Install Rspec and Nokogiri:

~~~
sudo gem install rspec
sudo gem install nokogiri
~~~


### install the gems in the local folder of the project
~~~
bundle install --path vendor/bundle
~~~

If bundle install fail, use *sudo*


## Install and download Docker and Docker-compose:

See the DOCKER.md for installation.


## Prepare local environment for run test:

First run Rake:

~~~
rake
~~~

That will raise the Consensus web in your localhost:4567

To run the test you must have the Consensus app up, then in other terminal you can run the tests with:

All the tests:
	 
~~~
rake test
~~~
	
The unitarian spec tests:
	
~~~
rake tdd
~~~
	
The behauvior spec tests:
	
~~~
rake bdd
~~~
	   
    

## Prepare docker environment to run test:

Be sure that you have the last docker version & docker-compose version 


Make the build for the docker-compose:

~~~
docker-compose build
~~~

Then make the docker compose up, to run the app:

~~~
docker-compose up
~~~

And after the docker-compose up, in other terminal run the tests:

All the tests:
	 
~~~
docker-compose run web rake test
~~~
	
The unitarian spec tests:
	
~~~
docker-compose run web rake tdd
~~~
	
The behauvior spec tests:
	
~~~
docker-compose run web rake bdd
~~~
