# config valid only for current version of Capistrano
lock '3.6.1'

#set :application, 'slylist'
#set :repo_url, "git@github.com:kaygorod/lists.git"
#set :unicorn_config_path, "#{current_path}/config/production/unicorn/unicorn.rb"
#set :linked_files, fetch(:linked_files, []).push('config/database.yml','config/secrets.yml')
#set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system') # Строчка есть по умолчанию в deploy.rb, ее просто надо откомментировать
#namespace :deploy do
  #task :setup do
  #  before "deploy:migrate", :create_db
  #  invoke :deploy
  #end
 # task :create_db do
 #   on roles(:all) do
 #     within release_path do
 #       with rails_env: fetch(:rails_env) do
  #        execute :rake, "db:create"
 #       end
#      end
#    end
#  end
#  task :restart do
#    invoke 'unicorn:legacy_restart'
#  end
#end
#before :deploy, 'git:push'
#before 'deploy:setup', 'git:push'

set :application, 'slylist'
set :repo_url, "git@github.com:kaygorod/lists.git"
set :deploy_to, "/var/www/slylist"
set :linked_files, fetch(:linked_files, []).push('config/database.yml','config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :keep_releases, 3
#добавлено 29 августа 2016
set :ssh_options, :compression => false, :keepalive => true

namespace :deploy do
  %w[unicorn].each do |service|
    namespace service do
      %w[up down restart status].each do |command|
        desc "#{command.capitalize} #{service}"
        task command do
          on roles(:app) do
            execute "sudo sv #{command} #{fetch(:application)}_#{service}"
          end
        end
      end
    end
  end

  after :finished, 'unicorn:restart'
end

#namespace :deploy do

#  desc 'Restart application'
#  task :restart do
#    on roles(:app), in: :sequence, wait: 5 do
#      execute :touch, release_path.join('tmp/restart.txt')
#    end
#  end

#  after :publishing, 'deploy:restart'
#  after :finishing, 'deploy:cleanup'
#end
