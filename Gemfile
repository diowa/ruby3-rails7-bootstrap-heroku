# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.2'

gem 'rails', '7.1.3.4'

gem 'bootsnap', require: false
gem 'newrelic_rpm', '~> 9.10'
gem 'pg', '~> 1.5'
gem 'puma', '~> 6.4'
gem 'shakapacker', '8.0.0'
gem 'slim-rails', '~> 3.6'
gem 'turbo-rails', '~> 2.0'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
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
