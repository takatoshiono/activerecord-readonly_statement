# ActiveRecord::ReadonlyStatement

This gem provides a rack middleware `ActiveRecord::ReadonlyStatement::Middleware` to check database statements and raise `ActiveRecord::ReadonlyStatementError` if any statements are non read.

The middleware decides whether to enable checking by executing a code block in each request.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-readonly_statement'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-readonly_statement

## Usage

In Rails app,

config/initializers/activerecord-readonly_statement.rb:
```ruby
Rails.application.config.middleware.use ActiveRecord::ReadonlyStatement::Middleware
```

In Rack app,

config.ru:
```ruby
require 'activerecord/readonly_statement'
use ActiveRecord::ReadonlyStatement::Middleware
```

## Configuration

```ruby
ActiveRecord::ReadonlyStatement.configuration do |config|
  # Set the adapter class
  # TODO: config.adapter = :mysql2
  config.adapter = ActiveRecord::ConnectionAdapters::Mysql2Adapter

  # Determine which request is readonly
  config.enable_if do |env|
    env.fetch('REQUEST_METHOD') == 'GET'
  end
end
```

### Use in request testing

For example, set to be enable if X-Check-Readonly request header exists.

```ruby
config.enable_if do |env|
  env.fetch('X-Check-Readonly', nil).present?
end
```

And in your test

```ruby
get '/v1/your/api', headers: { 'X-Check-Readonly' => 'on' }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/takatoshiono/activerecord-readonly_statement.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
