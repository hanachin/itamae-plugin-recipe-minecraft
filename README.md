# Itamae::Plugin::Recipe::Minecraft

original startup script: [Tutorials/Server startup script - Minecraft Wiki](http://minecraft.gamepedia.com/Tutorials/Server_startup_script)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'itamae-plugin-recipe-minecraft'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install itamae-plugin-recipe-minecraft

## Usage

    include_recipe 'minecraft'

    service 'minecraft' do
      action :enable
    end

    service 'minecraft' do
      action :start
    end

### attributes

    {
      "minecraft": {
        "user": "minecraft",
        "max_heap": 2048,
        "min_heap": 1024
      }
    }

## Contributing

1. Fork it ( https://github.com/hanachin/itamae-plugin-recipe-minecraft/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
