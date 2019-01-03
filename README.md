# redirect-uri-ruby

**A Ruby gem for discovering a URL’s registered callback URLs for use with [Micropub](https://indieweb.org/Micropub) and [IndieAuth](https://indieweb.org/IndieAuth) clients.**

[![Gem](https://img.shields.io/gem/v/redirect-uri.svg?style=for-the-badge)](https://rubygems.org/gems/redirect-uri)
[![Downloads](https://img.shields.io/gem/dt/redirect-uri.svg?style=for-the-badge)](https://rubygems.org/gems/redirect-uri)
[![Build](https://img.shields.io/travis/com/jgarber623/redirect-uri-ruby/master.svg?style=for-the-badge)](https://travis-ci.com/jgarber623/redirect-uri-ruby)
[![Dependencies](https://img.shields.io/depfu/jgarber623/redirect-uri-ruby.svg?style=for-the-badge)](https://depfu.com/github/jgarber623/redirect-uri-ruby)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/jgarber623/redirect-uri-ruby.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/redirect-uri-ruby)
[![Coverage](https://img.shields.io/codeclimate/c/jgarber623/redirect-uri-ruby.svg?style=for-the-badge)](https://codeclimate.com/github/jgarber623/redirect-uri-ruby/code)

## Key Features

- Implements [Section 4.2.2](https://www.w3.org/TR/indieauth/#redirect-url) of [the W3C's IndieAuth Working Group Note](https://www.w3.org/TR/indieauth/).
- Supports Ruby 2.4 and newer.

## Getting Started

Before installing and using redirect-uri-ruby, you'll want to have [Ruby](https://www.ruby-lang.org) 2.4 (or newer) installed. It's recommended that you use a Ruby version managment tool like [rbenv](https://github.com/rbenv/rbenv), [chruby](https://github.com/postmodern/chruby), or [rvm](https://github.com/rvm/rvm).

redirect-uri-ruby is developed using Ruby 2.4.5 and is additionally tested against Ruby 2.5.3 using [Travis CI](https://travis-ci.com/jgarber623/redirect-uri-ruby).

## Installation

If you're using [Bundler](https://bundler.io), add redirect-uri-ruby to your project's `Gemfile`:

```ruby
source 'https://rubygems.org'

gem 'redirect-uri'
```

…and hop over to your command prompt and run…

```sh
$ bundle install
```

## Usage

### Basic Usage

With redirect-uri-ruby added to your project's `Gemfile` and installed, you may discover a URL's registered callback URLs by doing:

```ruby
require 'redirect-uri'

endpoints = RedirectUri.discover('https://sixtwothree.org')

puts endpoints # returns Array: ['https://sixtwothree.org/auth']
```

This example will search `https://sixtwothree.org` for valid callback URLs using the same rules described in [the W3C's IndieAuth Working Group Note](https://www.w3.org/TR/indieauth/#redirect-url). In this case, the program returns an array: `['https://sixtwothree.org/auth']`.

If no endpoints are discovered at the provided URL, the program will return an empty array:

```ruby
require 'redirect-uri'

endpoints = RedirectUri.discover('https://example.com')

puts endpoints # returns Array: []
```

### Advanced Usage

Should the need arise, you may work directly with the `RedirectUri::Client` class:

```ruby
require 'redirect-uri'

client = RedirectUri::Client.new('https://sixtwothree.org')

puts client.response # returns HTTP::Response
puts client.endpoints # returns Array: ['https://sixtwothree.org/auth']
```

### Exception Handling

There are several exceptions that may be raised by redirect-uri-ruby's underlying dependencies. These errors are raised as subclasses of `RedirectUri::Error` (which itself is a subclass of `StandardError`).

From [jgarber623/absolutely](https://github.com/jgarber623/absolutely) and  [sporkmonger/addressable](https://github.com/sporkmonger/addressable):

- `RedirectUri::InvalidURIError`

From [httprb/http](https://github.com/httprb/http):

- `RedirectUri::ConnectionError`
- `RedirectUri::TimeoutError`
- `RedirectUri::TooManyRedirectsError`

## Contributing

Interested in helping improve redirect-uri-ruby? Awesome! Your help is greatly appreciated. See [CONTRIBUTING.md](https://github.com/jgarber623/redirect-uri-ruby/blob/master/CONTRIBUTING.md) for details.

## Acknowledgments

redirect-uri-ruby wouldn't exist without Micropub, IndieAuth, and the hard work put in by everyone involved in the [IndieWeb](https://indieweb.org) movement.

redirect-uri-ruby is written and maintained by [Jason Garber](https://sixtwothree.org).

## License

redirect-uri-ruby is freely available under the [MIT License](https://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.
