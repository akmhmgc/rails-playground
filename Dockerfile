FROM ruby:2.7

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn
WORKDIR /app
COPY . /app
RUN bundle config --local set path 'vendor/bundle' \
  && bundle install

EXPOSE 3000
CMD bundle exec rails s -p ${PORT:-3000} -b 0.0.0.0