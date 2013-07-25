# Shinji

The official client library for Gendo.

## Installation

Add this line to your application's Gemfile:

```
gem 'shinji'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install shinji
```

Add the following to `/config/initializers/shinji.rb`:

```ruby
Shinji.configure do |config|
  config.app_key = "app_key" # substitute your gendo app key here
end
```

That's it! Shinji will now start collecting data for Gendo.

## Additional Configuration

By default, Shinji will post the contents of SQL statements to Gendo. You can
redact this data before sending like so:

```ruby
Shinji.configure do |config|
  config.redactable_sql_tokens << "super_secret_data_column"
end
```

Any statement containing the supplied terms will not be sent.
By default, anything matching "password" will be redacted.

By default, Shinji will only collect data in Rails production environment.

You can set this manually like so:

```ruby
Shinji.configure do |config|
  config.enabled = true
end
```

## Contributing

Fork, Branch, Pull Request.
