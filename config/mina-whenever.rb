# set :app_name, "app_name"  # set app name here or deploy.rb

namespace :whenever do
  desc "Clear crontab"
  task :clear do
    invoke :environment
    queue %{
      echo "-----> Clear crontab for #{app_name}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; bundle exec whenever --clear-crontab #{app_name} --set 'environment=production&path=#{deploy_to!}/#{current_path!}']}
    }
  end
  desc "Update crontab"
  task :update do
    invoke :environment
    queue %{
      echo "-----> Update crontab for #{app_name}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; bundle exec whenever --update-crontab #{app_name} --set 'environment=production&path=#{deploy_to!}/#{current_path!}']}
    }
  end
  desc "Write crontab"
  task :write do
    invoke :environment
    queue %{
      echo "-----> Update crontab for #{app_name}"
      #{echo_cmd %[cd #{deploy_to!}/#{current_path!} ; bundle exec whenever --write-crontab #{app_name} --set 'environment=production&path=#{deploy_to!}/#{current_path!}']}
    }
  end
end
