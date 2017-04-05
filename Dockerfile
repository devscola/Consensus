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
RUN gem install rake
RUN gem install rerun
RUN gem install sinatra
RUN gem install capybara
RUN gem install rspec
RUN gem install selenium-webdriver
WORKDIR $app
CMD bundle install
