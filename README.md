# Consensus

## Install gems

*Bundler* gem has to be installed first:

```
gem install bundler
```

### install the gems in the local folder of the project
```
bundle install --path vendor/bundle
```

## Run tests

```
bundle exec rspec
```

## Launch the app

```
bundle exec rake
```
The app will be served on *http://localhost:4567/index.html*


# Download the docker of Consensus

~~~
docker pull elferrer/ruby
~~~

2.- Run the container:

~~~
docker run -it --name consensus -v  $(pwd):/opt/consensus elferrer/ruby bundle exec rspec
~~~

