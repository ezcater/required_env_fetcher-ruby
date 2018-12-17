# required_env_fetcher

In certain situations it makes sense to allow default values of environment variables that
are otherwise required. For example, imagine we're precompiling assets as part of CI when
we don't have access to some environment variables we require for the app be up and
accepting requests, but aren't required for asset compilation. Using this library we can
designate it safe to use default values in those situations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "required_env_fetcher"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install required_env_fetcher

## Usage

When you have an environment variable that is required - perhaps with code like:

```ruby
# in config/application.rb
module MyApp
  class Application < Rails::Application
    config.x.redis_url = ENV.fetch("REDIS_URL")
  end
end
```

When you run `rails assets:precompile` you'll always need to have a `REDIS_URL` set or else loading
the application environment will fail. You can update your initializer to do something like:

```ruby
config.x.redis_url = RequiredEnvFetcher.fetch("REDIS_URL")
```

Now you can run `SKIP_REQUIRED_ENV_VAR_ENFORCEMENT=true rails assets:precompile` and so long as none of
your assets rely on the redis URL they will be able to compile.

If you need a specific default value (for example, if the value needs to be a valid URL) you can do:

```ruby
config.x.redis_url = RequiredEnvFetcher.fetch("REDIS_URL")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then,
run `rake spec` to run the tests. You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org)
.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/ezcater/required_env_fetcher-ruby.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
