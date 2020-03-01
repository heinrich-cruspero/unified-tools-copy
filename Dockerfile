# gets the a base ruby docker image
FROM ruby:2.6.5

# app home directory
ENV APP_HOME /unified-tools

# install dependencies
ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev nodejs npm yarn

# clean up
RUN apt-get clean autoclean && apt-get autoremove -y
RUN rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log

# create a folder APP_HOME in the docker container and go into that folder
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile* $APP_HOME/
COPY yarn.lock $APP_HOME/
COPY package.json $APP_HOME/

# Run bundle & yarn install to install gems inside the gemfile
RUN gem install bundler:2.0.2
RUN bundle install --without development test

# Copy the whole app
COPY . $APP_HOME

CMD bundle exec puma -C config/puma.rb
