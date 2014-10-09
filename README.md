# openshift graph demo app


## Installing Client Tools

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
$ rhc app create demo ruby-2.0 --from-code https://github.com/SIOS-OSS/openshift_demo.git
```

