FROM ruby:2.4.0

RUN mkdir -p /opt/consensus
ADD . /opt/consensus
WORKDIR /opt/consensus

CMD . /opt/consensus
ENV .env /opt/consensus
CMD /bin/bash env .env

ENV CONSENSUS_MODE development

RUN apt-get update
#RUN apt-get install g++ -y
#RUN apt-get install make -y
#RUN apt-get install ruby-rack -y
#RUN apt-get install build-essential patch zlib1g-dev liblzma-dev libxslt-dev libxml2-dev -y
RUN gem install bundler
#RUN gem install rspec
#RUN gem install nokogiri
RUN bundle install

