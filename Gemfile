# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '7.2.2.2'

gem 'bootsnap', require: false
gem 'newrelic_rpm', '~> 9.22'
gem 'pg', '~> 1.6'
gem 'puma', '~> 7.0'
gem 'shakapacker', '9.1.0'
gem 'slim-rails', '~> 3.7'
gem 'turbo-rails', '~> 2.0'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'i18n-tasks', require: false
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
  gem 'slim_lint', require: false
end

group :development do
  gem 'annotaterb', require: false
  gem 'rack-mini-profiler'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'email_spec'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  gem 'webmock', require: false
end

group :production do
  gem 'rack-timeout', '~> 0.7.0'
end
