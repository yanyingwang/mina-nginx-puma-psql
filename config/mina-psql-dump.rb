RYAML = <<-BASH
function ryaml {
  ruby -ryaml -e 'puts ARGV[1..-1].inject(YAML.load(File.read(ARGV[0]))) {|acc, key| acc[key] }' "$@"
};
BASH

namespace :psql do
  task :dump do
    isolate do
      invoke :environment

      queue RYAML
      queue "USERNAME=$(ryaml #{deploy_to}/shared/config/database.yml #{rails_env} username)"
      queue "PASSWORD=$(ryaml #{deploy_to}/shared/config/database.yml #{rails_env} password)"
      queue "DATABASE=$(ryaml #{deploy_to}/shared/config/database.yml #{rails_env} database)"
      queue "PGPASSWORD=$PASSWORD pg_dump --host localhost --username $USERNAME --verbose --clean --no-owner --no-acl --format=c $DATABASE > #{deploy_to}/#{application}.dump"

      mina_cleanup!
    end

    %x[ scp #{user}@#{domain}:#{deploy_to}/#{application}.dump db/#{application}.dump ]
=begin
    %x[ bundle exec rake db:drop ]
    %x[ bundle exec rake db:create ]

    %x[ #{RYAML}
    USERNAME=$(ryaml config/database.yml development username);
    PASSWORD=$(ryaml config/database.yml development password);
    DATABASE=$(ryaml config/database.yml development DATABASE);
    PGPASSWORD=$PASSWORD pg_restore --verbose --host localhost --username $USERNAME --clean --no-owner --no-acl --dbname $DATABASE ./#{application}.dump ]
=end
  end
end
