FROM ruby:3.0.3

RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs postgresql-client

WORKDIR /app

COPY . /app

COPY Gemfile /app/Gemfile

COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]