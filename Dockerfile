FROM ruby:2.4.0

RUN mkdir -p /opt/consensus
ADD . /opt/consensus
WORKDIR /opt/consensus

CMD . /opt/consensus
ENV .env /opt/consensus
CMD /bin/bash env .env

ENV CONSENSUS_MODE development

RUN apt-get update
RUN gem install bundler
RUN bundle install
