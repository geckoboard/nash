# Nash

Nash is a Hashie that allows you to create nested Dashes.

## Installation

Add this line to your application's Gemfile:

    gem 'nash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nash

## Usage

    class Car
      property :engine, :required => true, :class => Engine 
    end

    class Engine
      property :crankshaft, :required => true
      property :nitro, :default => false
    end

    Car.new "engine" => {"crankshaft" => true, "nitro" => false}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
