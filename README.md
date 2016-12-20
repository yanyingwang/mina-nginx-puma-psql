# quickly configure your rails app's deployment with mina nginx puma and psql



## files in config and lib dir

cp files in `config/*` and `lib/*` to your rails app's same name dir.




## config it

modify `username` and `appname` and others in content of file `config/deploy`.




## files in server

config ssh and run `mina setup` on local to get ready of server's app dir structure.

cp `config/puma.rb` to server `~/username/appname/shared/config/`.





## usage

### mina tasks

    $ mina tasks

    $ mina rails:db_create

    $ mina puma:start -vv

    $ mina git:clone

    $ mina deploy force_assets=1




### db sync from server side to local

dump db from server to local:

    $ mina psql:dump


restore synced db file to local db:

    $ rake psql:restore

