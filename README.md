# quickly configure your rails app's deployment with mina nginx puma and psql


## mina version

mina version this repo is with 0.3.8, that I didn't use version 1.0.0 cause of too much bugs with new version.


## Gemfile

Your Rails's Gemfile should include below lines:

~~~ruby
gem 'mina', '~> 0.3.8', require: false
gem 'mina-puma', :require => false
gem 'mina-nginx', :require => false
~~~



## files in config and lib dir

cp files in `config/*` and `lib/*` to your rails app's same name dir.




## config it

modify `username` `user` `appname` and others in content of file `config/deploy`.




## files in server

config ssh and run `mina setup` on local to get ready of server's app dir structure.

cp `config/puma.rb` to server `~/username/appname/shared/config/`.



## nginx init

reference file `nginx-server.conf` to configure your server's nignx 


## workaround for bundle not found that can not 'rake db:create' in server.
1. git clone source to server dir.
2. cd dir.
3. `gem install bundler`
4. `bundle`
5. `RAIL_ENV=production rake db:create`

## usage


### mina tasks


    $ mina --tasks

    $ mina tasks

    $ mina 'rake[db:create]'

    $ mina rails:db_create

    $ mina puma:start -vv

    $ mina nginx restart

    $ mina git:clone

    $ mina deploy force_assets=1

    $ mina 'run[gem install bundler]'




### db sync from server side to local

dump db from server to local:

    $ mina psql:dump


restore synced db file to local db:

    $ rake psql:restore





