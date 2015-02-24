# config valid only for Capistrano 3.3
lock '3.3.5'

set :rvm_ruby_version, '2.0.0-p247'      # Defaults to: 'default'
set :application, 'helicat'
set :repo_url, 'git@github.com:sul-dlss/heli_cat.git'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/helicat/helicat-app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{db/production.sqlite3 config/database.yml config/dlss_ep_email config/UPS.yml config/admins.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log lib/course_work_xml tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end
