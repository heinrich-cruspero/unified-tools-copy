# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.1'
gem 'sass-rails', '>= 6'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'faker', '~> 2.10', '>= 2.10.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'devise'
gem 'omniauth-google-oauth2'
gem 'pg_search', '~> 2.3'
gem 'pundit'
gem 'smarter_csv', '~> 1.2', '>= 1.2.6'
gem 'will_paginate', '~> 3.2', '>= 3.2.1'
gem 'will_paginate-bootstrap4', '~> 0.2.2'
gem 'delayed_job_active_record'
gem 'delayed_job', '~> 4.1', '>= 4.1.2'
