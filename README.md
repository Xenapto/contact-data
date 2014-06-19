# The contact-data gem

![Gem Version](http://img.shields.io/gem/v/contact-data.svg?style=flat)&nbsp;[![Code Climate](http://img.shields.io/codeclimate/github/Xenapto/contact-data.svg?style=flat)](https://codeclimate.com/github/Xenapto/contact-data)&nbsp;[![Coverage Status](https://img.shields.io/coveralls/Xenapto/contact-data.svg?style=flat)](https://coveralls.io/r/Xenapto/contact-data?branch=master)
[![Developer status](http://img.shields.io/badge/developer-awesome-brightgreen.svg?style=flat)](http://xenapto.com)
![build status](https://circleci.com/gh/Xenapto/contact-data.png?circle-token=4c6f3dcc1912d30c8d903ae767f0beee94d9b4e2)

Retrieves information about people and organizations from http://public.xenapto.com

## Installation

Add this line to your application's Gemfile:

    gem 'contact-data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install contact-data

## Usage

Examples:

```ruby
ContactData.search 'John Smith III'
```

Or you can create an instance if you need to call it several times

```ruby
contact_data = ContactData::Contact.new

['John Smith', 'Example Inc.', 'Crazy Ventures LLC'].each do |name|
  contact_data.search name
end
```

ContactData will make an intelligent guess at the type of the name but it's not infallible. ContactData likes it if you tell it whether the name is a person or an organization:

```ruby
contact_data = ContactData::Contact.new 'Di Doo Doo d.o.o.', contact_type: :organization
contact_data.search
```

## Contributing

1.  Fork it
1.  Create your feature branch (`git checkout -b my-new-feature`)
1.  Commit your changes (`git commit -am 'Add some feature'`)
1.  Push to the branch (`git push origin my-new-feature`)
1.  Create new Pull Request

## Acknowledgements

1.  Thanks to Ryan Bigg for the guide to making your first gem https://github.com/radar/guides/blob/master/gem-development.md
