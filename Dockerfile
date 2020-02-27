# gets the docker image of ruby 2.5 and lets us build on top of that
FROM ruby:2.6.3-slim

# install rails dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm
RUN npm install -g yarn

# create a folder /unified-tools in the docker container and go into that folder
RUN mkdir /unified-tools
WORKDIR /unified-tools

# Copy the Gemfile and Gemfile.lock from app root directory into the /myapp/ folder in the docker container
COPY Gemfile /unified-tools/Gemfile
COPY Gemfile.lock /unified-tools/Gemfile.lock

# Run bundle & yarn install to install gems inside the gemfile
RUN gem install bundler:2.0.2
RUN bundle install
RUN yarn install --check-files
RUN bundle exec rake assets:precompile

# Copy the whole app
COPY . /unified-tools