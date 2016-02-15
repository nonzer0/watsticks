FROM ruby:2.2.0

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y nodejs

RUN mkdir /watsticks

WORKDIR /watsticks

ADD Gemfile /watsticks/Gemfile
ADD Gemfile.lock /watsticks/Gemfile.lock

RUN bundle install

ADD . /watsticks
