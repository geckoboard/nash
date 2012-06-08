# Nashie
Nashie provides a Hashie that can nest other Hashies.
This allows you to rapidly create complex nested hashes.

## Installation

Add this line to your application's Gemfile:

    gem 'nashie'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nashie

## Usage

    class Car < Hashie::Nash
      class Engine < Hashie::Nash
        property :crankshaft, :required => true
        property :nitro, :default => false
      end
      
      property :engine, :required => true, :class => Engine 
    end

    Car.new "engine" => {"crankshaft" => true, "nitro" => false}

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
