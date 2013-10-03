# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

HeliCat::Application.load_tasks


task :ci do
  RAILS_ENV="test"
  Rake::Task["db:migrate"].invoke
  Rake::Task["spec_with_js"].invoke
end
RSpec::Core::RakeTask.new(:spec_with_js) do |t|
  if `which phantomjs` == ""
    t.rspec_opts = "--tag ~js"
  end
end