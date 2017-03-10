FROM ruby:2.4.0

ENV app /opt/consensus
ENV CONSENSUS_MODE = development
RUN mkdir -p $app
RUN apt-get update
RUN apt-get install g++
RUN apt-get install make
RUN gem install bundler
WORKDIR $app
