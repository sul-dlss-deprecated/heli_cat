source 'https://rubygems.org'
source 'http://sul-gems.stanford.edu'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Include bootsrap-sass assets
gem 'bootstrap-sass', '~> 2.3.2.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'nokogiri'
gem 'rest-client'

gem 'kaminari'

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
  gem 'capistrano', "< 3.0.0"
  gem 'capistrano-ext'
  gem 'rvm-capistrano'
  gem 'lyberteam-devel', '>=1.0.0'
  gem 'lyberteam-gems-devel', '>=1.0.0'
  gem 'net-ssh-krb'
end
gem 'gssapi', :git => 'https://github.com/cbeer/gssapi.git'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
