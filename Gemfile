# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.0.2.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.3'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Transpile app-like JavaScript. Read more: https://github.com/shakacode/shakapacker
gem 'shakapacker', '~> 6.2'

# Turbo makes navigating your web application faster. Read more: https://github.com/hotwired/turbo-rails
gem 'turbo-rails', '~> 1.0'

# Template Engine
gem 'slim-rails', '~> 3.4'

# App monitoring
gem 'newrelic_rpm', '~> 8.5'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 2.20'
  gem 'rspec-rails', '~> 5.1'
  gem 'rubocop', '~> 1.26', require: false
  gem 'rubocop-performance', '~> 1.13', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'rubocop-rspec', '~> 2.9', require: false
  gem 'slim_lint', '~> 0.22.1', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'capybara', '~> 3.36'
  gem 'email_spec', '~> 2.2'
  gem 'selenium-webdriver', '~> 4.1'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'simplecov-lcov', '~> 0.8.0', require: false
  gem 'webmock', '~> 3.14', require: false
end

group :staging, :production do
  gem 'rack-timeout', '~> 0.6.0'
end
