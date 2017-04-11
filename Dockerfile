FROM ruby:2.4.0

RUN mkdir -p /opt/consensus
ADD . /opt/consensus
WORKDIR /opt/consensus

ENV CONSENSUS_MODE development

RUN apt-get update
RUN gem install bundler
RUN bundle install
