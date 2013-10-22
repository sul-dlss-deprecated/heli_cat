set :rails_env, "production"
set :deployment_host, "sulwebapp5.stanford.edu"

set :rvm_type, :system
set :rvm_ruby_string, "ruby-2.0.0-p247"

role :web, deployment_host
role :app, deployment_host
role :db,  deployment_host, :primary => true