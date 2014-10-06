# README


## Set Up

```bash
$ sudo yum install -y rubygem-rhc
$ rhc app create demo ruby-2.0 mysql-5.5 --from-code https://github.com/kazuhisya/graph_demo.git
```


## Connect and login your app

```bash
$ rhc ssh demo
```

## Insert DB Seed (in your app instance)

```bash
$ cd ${OPENSHIFT_REPO_DIR}

$ source $OPENSHIFT_CARTRIDGE_SDK_BASH
$ source ${OPENSHIFT_RUBY_DIR}/lib/ruby_context

$ ruby_with_nodejs_context "bundle exec rake db:migrate RAILS_ENV=${RAILS_ENV:-production}"
$ ruby_with_nodejs_context "bundle exec rake db:seed RAILS_ENV=${RAILS_ENV:-production}"
$ ruby_with_nodejs_context "bundle exec rake assets:precompile RAILS_ENV=${RAILS_ENV:-production}"
$ ctl_all restart
```
