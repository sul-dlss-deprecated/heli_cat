source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.8'
gem 'sprockets'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
gem 'mysql2'

# Use SCSS for stylesheets
gem 'sass-rails'

# Include bootsrap-sass assets
gem 'bootstrap-sass', '~> 2.3.2.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 2' # 5.x requires javascript changes..

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'nokogiri'
gem 'rest-client'

gem 'kaminari'

# Use honeybadger for exception reporting
gem 'honeybadger'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "therubyracer", group: :assets

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem "poltergeist"
  gem "database_cleaner", "< 1.1.0"
end

# gems necessary for capistrano deployment
group :deployment do
  gem 'capistrano', "~> 3.0"
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'dlss-capistrano'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
