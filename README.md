# MarineTraffic

*Warning:* This gem is a work in progress!

This is a API wrapper for MarineTraffic written in Ruby.
You can find more information about the API of MarineTraffic on [their API description page](https://www.marinetraffic.com/en/ais-api-services)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marinetraffic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marinetraffic

## Usage

### Authentication

You authenticate to the MarineTraffic API by providing your secret API key in the request.
To use your API key, you need only set Marinetraffic.api_key equal to the key. The Ruby library will automatically send this key in each request.

```ruby
require "stripe"
Marinetraffic.api_key = "2571121d07b9ce09c1abc34db75606a840a2c68c"
```

### Find vessels

You can call vessel informations by the Vessel.find method. This method accepts a *MMSI Number* and an optional flag for *extended data* (false by default).

```ruby
vessel = Marinetraffic::Vessel.find("311026000", true)
vessel.mmsi      # => "311026000"
vessel.lat       # => "54.520730"
vessel.lng       # => "10.421800"
vessel.ship_name # => "NINA"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/mordaroso/marinetraffic/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
