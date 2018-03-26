[![Build Status](https://travis-ci.org/ecraft/logging_library.svg?branch=master)](https://travis-ci.org/ecraft/logging_library) [![Gem Version](https://badge.fury.io/rb/logging_library.svg)](https://badge.fury.io/rb/logging_library)

# LoggingLibrary

This library provides logging support for your application or framework, with an opinionated default configuration in terms of log
format, etc.

It is compatible with both JRuby and MRI.

Wraps the functionality of [mixlog-log](https://github.com/chef/mixlib-log).

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'logging_library'
```

And then execute:

    $ bundle install

## Usage

```ruby
require 'logging_library'

class MyClass
  include LoggingLibrary::Loggable

  def load_data_from_database
    logger.info('Starting to load data from database')

    # DEBUG-level messages are not printed by default; see logger#level= if you
    # want to customize the log level.
    logger.debug("Running as user #{current_user}")

    # If you use blocks to wrap log messages, they'll only execute if needed
    logger.debug { "Score for all participants: #{expensive_operation}" }
  end

  def current_user
    'john_doe'
  end

  def expensive_operation
    sleep 5
    9_000
  end
end
```

## Environment variables

- `LOGGING_LIBRARY_DISABLE_TIMESTAMPS` - set this to any value to disable
  timestamping which is otherwise performed on log entries when running in
  interactive/TTY mode. This setting can be useful in scenarios where you
  would otherwise get double timestamps on each line.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/ecraft/logging_library. This project is intended to
be a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

### Documentation

We strive to write API documentation inline in [YARD](http://yardoc.org) format.

Generate API documentation using `yardoc` or `rake yard`.

Preview API documentation locally with

```
bundle exec yard server -r
```

### Releasing a new version

- Bump the version in `version.rb`
- Create the tag:

  ```
  $ git release v1.0.x`
  ```

- Build the gemfile and push it to Rubygems.org:

  ```shell
  $ bundle exec rake build release
  ```

- Generate the changelog (`cargo install changelog-rs && changelog-rs .`) and copy the relevant lines to [the releases page](https://github.com/ecraft/logging_library/releases).

### License

MIT
