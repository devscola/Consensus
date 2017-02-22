FROM ruby:2.4.0-alpine

RUN mkdir -p /opt/consensus
WORKDIR /opt/consensus
COPY Gemfile Gemfile
RUN apk update
RUN apk add g++
RUN apk add make
RUN bundle install
