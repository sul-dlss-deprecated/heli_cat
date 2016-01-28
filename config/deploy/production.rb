server 'helicat-prod.stanford.edu', user: 'helicat', roles: %w{web app db}

Capistrano::OneTimeKey.generate_one_time_key!
set :rails_env, "production"
