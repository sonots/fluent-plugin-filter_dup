# fluent-plugin-filter_dup

[![Build Status](https://secure.travis-ci.org/sonots/fluent-plugin-filter_dup.png?branch=master)](http://travis-ci.org/sonots/fluent-plugin-filter_dup)

A Fluentd sample filter plugin to duplicate messages

## Requirements

Fluentd >= v0.12

## Install

Use RubyGems:

```
gem install fluent-plugin-filter_dup
```

## Configuration Example

```apache
<source>
  forward
</source>

<filter **>
  type dup
</filter>

<match **>
  type stdout
</match>
```

You should be able to see duplicated messages, try as:

```
$ echo '{"a":"foo","b":"bar"}' | fluent-cat raw.test
```

## Parameters

None

## ChangeLog

See [CHANGELOG.md](CHANGELOG.md) for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2014 Naotoshi Seo. See [LICENSE](LICENSE) for details.
