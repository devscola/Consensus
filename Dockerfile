FROM ruby:2.4.0

ENV SINATRA_DEFAULT_PORT 4567
ENV app /opt/consensus
ENV CONSENSUS_MODE development

RUN apt-get update
RUN apt-get install g++
RUN apt-get install make

RUN mkdir -p $app
WORKDIR $app
