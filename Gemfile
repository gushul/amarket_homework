# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'jbuilder'
gem 'pg', '~> 1.4'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.5'
gem 'will_paginate', '~> 4.0.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-core'
  gem 'rspec-rails'
  gem 'rswag-api'
  gem 'rswag-specs'
  gem 'rswag-ui'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
