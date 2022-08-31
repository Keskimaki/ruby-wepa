FROM ruby:3.1.2

EXPOSE 3000

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install

COPY . ./

CMD ["rails", "server", "-b", "0.0.0.0"]
