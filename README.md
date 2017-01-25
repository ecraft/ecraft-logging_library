# Ecraft::LoggingLibrary

This library provides logging support for your application or framework, with an opinionated default configuration in terms of log
format, etc. It is compatible with both JRuby and MRI.

## Installation

Add this line to your application's `Gemfile`, inside a `source` block:

```ruby
source 'https://gem.fury.io/ecraft-gems/' do
  gem 'ecraft-logging_library'
end
```

And then execute:

    $ bundle install

## Usage

```ruby
require 'ecraft/logging_library'

class MyClass
  include Ecraft::LoggingLibrary::Loggable

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
https://github.com/ecraft/ecraft-logging_library. This project is intended to
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

