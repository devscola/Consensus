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

to run _all_ tests use:
```
bundle exec rake test_all
```

to run _only_ unitarian specs use:
```
bundle exec rake test
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

