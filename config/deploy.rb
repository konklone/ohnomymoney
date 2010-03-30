set :environment, :production

set :user, 'klondike'
set :application, 'ohnomymoney'

set :deploy_to, "/home/#{user}/ohnomymoney.com"
set :domain, 'ohnomymoney.com'

set :scm, :git
set :repository, "git://github.com/klondike/#{application}.git"
set :branch, 'master'

set :deploy_via, :remote_cache
set :runner, user
set :admin_runner, runner

role :app, domain
role :web, domain

set :use_sudo, false
after "deploy", "deploy:cleanup"
after "deploy:update_code", "deploy:shared_links"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :migrate do; end
  
  desc "Restart the server"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join current_path, 'tmp', 'restart.txt'}"
  end
  
  desc "Get shared files into position"
  task :shared_links, :roles => [:web, :app] do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/buxfer.yml #{release_path}/updater/buxfer/buxfer.yml"
    run "ln -nfs #{shared_path}/wesabe.yml #{release_path}/updater/wesabe/wesabe.yml"
    run "ln -nfs #{shared_path}/cacert.pem #{release_path}/updater/wesabe/cacert.pem"
    run "ln -nfs #{shared_path}/dreamhost.rb #{release_path}/dreamhost.rb"
    run "rm #{File.join release_path, 'tmp', 'pids'}"
    run "rm #{File.join release_path, 'public', 'system'}"
    run "rm #{File.join release_path, 'log'}"
  end
end