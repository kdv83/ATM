FROM ruby:2.5
ENV APP_HOME /atm

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN bundle install