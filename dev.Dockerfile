FROM ruby:2.5
RUN apt-get update && \
    apt-get install -y build-essential postgresql tzdata imagemagick vim curl gnupg
RUN gem install bundler
RUN gem install rails -v 6.0
RUN gem install rubocop-rspec
WORKDIR /api
ADD Gemfile Gemfile.lock /api/
RUN bundle install
