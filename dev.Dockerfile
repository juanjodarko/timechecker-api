FROM ruby:3.0.1
RUN apt-get update && \
    apt-get install -y build-essential postgresql tzdata imagemagick vim curl gnupg
RUN gem install bundler -v 2.1.2
RUN gem install rails -v 6.0.6.1
RUN gem install rubocop-rspec
WORKDIR /api
ADD Gemfile Gemfile.lock /api/
RUN bundle install
