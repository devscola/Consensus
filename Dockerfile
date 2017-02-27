FROM ruby:2.4.0-alpine

RUN mkdir -p /opt/consensus
ADD . /opt/consensus
WORKDIR /opt/consensus
RUN apk update
RUN apk add g++
RUN apk add make
RUN bundle install
EXPOSE 5000
