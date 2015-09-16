# include the puma recipes: https://github.com/puma/puma/blob/master/lib/puma/capistrano.rb
require 'puma/capistrano'
require 'rvm/capistrano'
require 'bundler/capistrano'
require 'sidekiq/capistrano'
# require "coalmine/capistrano" # notify Coalmine there is a deployment

server "l1.snoogen.com", :web, :app, :db, primary: true

set :application, "podscribe"
set :user, "webuser"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, :git
set :repository, "git@github.com:mike-ball/podscribe.git"
# set :scm_user, "mike-ball"
set :branch, fetch(:branch, "master")

set :ssh_options, { forward_agent: true }

default_run_options[:pty] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  task :setup_config, roles: :app do
    # sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    # run "mkdir -p #{shared_path}/tmp/sockets"
    # sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/exports"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :nginx_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/conf.d/#{application}.conf"
    # on different distros (ubuntu) the directory might be /etc/nginx/sites-enabled/ or some variation of conf.d/sites-enabled/
  end
  after "deploy:cold", "deploy:nginx_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    # run "ln -nfs #{shared_path}/exports #{release_path}/exports"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

end

namespace :db do
  task :close_connections do
    # prevent any more connections to the DB
    ActiveRecord::Base.connection.execute("update pg_database set datallowconn = 'false' where datname = 'podscribe_production';")
    #close existing connections
    ActiveRecord::Base.connection.execute("SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'podscribe_production';")
  end
  before "db:drop", "db:close_connections"

end