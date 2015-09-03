require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/unicorn'
# require 'mina_sidekiq/tasks' # for background tasks

set :domain, '128.199.73.11' # single server deploy
set :domains_do, ['128.199.73.11']
set :deploy_to, '/srv/www/gifly.dented.io'
set :repository, 'git@github.com:dentedio/gifly.git'
set :branch, 'develop'
set :deploy_environment, 'production'
set :forward_agent, true
set :unicorn_pid, "#{deploy_to}/shared/tmp/pids/unicorn.pid"

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/secrets.yml', 'config/newrelic.yml', 'log', 'tmp', 'config/settings']

# Optional settings:
set :user, 'deployer'
set :identity_file, "#{ENV['HOME']}/.ssh/id_rsa"

set :user_do, 'root'    # Username in the server to SSH to.
set :identity_file_do, "#{ENV['HOME']}/.ssh/id_rsa" # ssh key used to connect

set :rbenv_path, '/usr/local/rbenv'

task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  queue %{export RBENV_ROOT=#{rbenv_path}}
  queue %{export RAKE_ENV=#{deploy_environment}}
  queue %{export RAILS_ENV=#{deploy_environment}}
  invoke :'rbenv:load'

end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/secrets.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/secrets.yml'."]

  queue! %[touch "#{deploy_to}/shared/config/newrelic.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/newrelic.yml'."]

  queue! %[mkdir -p "#{deploy_to}/shared/config/settings"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config/settings"]

  queue! %[touch "#{deploy_to}/shared/config/settings/application.rb"]
  queue  %[echo "-----> Be sure to edit 'shared/config/settings/application.rb'."]

  queue! %[touch "#{deploy_to}/shared/config/settings/production.rb"]
  queue  %[echo "-----> Be sure to edit 'shared/config/settings/production.rb'."]

  # Puma needs a place to store its pid file and socket file.
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/sockets"]

  queue! %[mkdir "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]
end

desc "Deploy to all servers"
task :deploy_do do
  isolate do
    set :user, user_do
    set :identity_file, identity_file_do
    domains_do.each do |d|
      set :domain, d
      invoke :deploy
      run!
    end
  end
end

namespace :passenger do
  task :restart do
    queue "touch #{deploy_to}/current/tmp/restart.txt"
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  queue  %[echo "-----> Server: #{domain}."]
  queue  %[echo "-----> Path: #{deploy_to}."]
  queue  %[echo "-----> Environment: #{deploy_environment}."]
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    to :launch do
      invoke :'unicorn:restart'
      invite :'sync_db'
    end

    invoke :'deploy:cleanup'
  end
end

desc "Sync Database"
task :sync_db => :environment do
  queue "cd #{deploy_to}/current ; bundle exec rake nobrainer:sync_schema"
end
