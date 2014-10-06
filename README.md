# graph demo app


## How to carry out OpenShift

- you need a `rhc` command. and get it now!

```bash
$ sudo yum install -y rubygem-rhc
```

or

```bash
$ gem install rhc
```

## Just run

```bash
$ rhc app create demo ruby-2.0 --from-code https://github.com/kazuhisya/graph_demo.git
```

