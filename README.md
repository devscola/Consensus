# Consensus

## Preconfiguration of linux systems

Install Ruby and Ruby-dev:

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



## Run tests

to run _all_ tests use:
~~~
bundle exec rake test_all
~~~


to run _only_ unitarian specs use:
~~~
bundle exec rake test
~~~


## Launch the app

~~~
bundle exec rake
~~~
The app will be served on *http://localhost:4567/index.html*


# Download the docker of Consensus

~~~
docker pull elferrer/ruby
~~~

2.- Run the container:

~~~
docker run -it --name consensus -v  $(pwd):/opt/consensus elferrer/ruby bundle exec rspec
~~~


