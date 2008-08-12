set :application, "minds.qi64.com"
set :repository,  "."

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :user, "qi64"
set :deploy_to, "/home/#{user}/#{application}"
set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :deploy_via, :copy
set :copy_remote_dir, "/home/#{user}"
set :copy_strategy, :export

role :app, application
role :web, application
role :db,  application, :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end