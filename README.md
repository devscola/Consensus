# Consensus

## Preconfiguration of linux systems at no dockerized environment

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


## Run tests in local environment:


1. Download consensus git: 

~~~
git clone https://github.com/devscola/consensus
~~~


2.  To run the test you must have the Consensus app up:

First run Rake:

~~~
rake
~~~

That will raise the Consensus web in your localhost:4567

Then in other terminal you can run the tests with:

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

To run specific test you can do it like this:
       
~~~
rspec -e 'any word of the test title' 
~~~
    

## Prepare docker environment for run test:
    
Load DOCKER.md.
