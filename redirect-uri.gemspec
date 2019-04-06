lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'redirect_uri/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = ['>= 2.4', '< 2.7']

  spec.name          = 'redirect-uri'
  spec.version       = RedirectUri::VERSION
  spec.authors       = ['Jason Garber']
  spec.email         = ['jason@sixtwothree.org']

  spec.summary       = 'Discover a URL’s registered callback URLs for use with Micropub and IndieAuth clients.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jgarber623/redirect-uri-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|spec)/}) }

  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '~> 0.67.2'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.31'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
  spec.add_development_dependency 'simplecov-console', '~> 0.4.2'
  spec.add_development_dependency 'webmock', '~> 3.5'

  spec.add_runtime_dependency 'absolutely', '~> 1.1'
  spec.add_runtime_dependency 'addressable', '~> 2.6'
  spec.add_runtime_dependency 'http', '~> 4.1'
  spec.add_runtime_dependency 'nokogiri', '~> 1.10'
end
