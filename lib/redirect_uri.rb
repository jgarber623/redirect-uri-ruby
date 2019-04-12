require 'absolutely'
require 'addressable/uri'
require 'http'
require 'nokogiri'

require 'redirect_uri/version'
require 'redirect_uri/error'
require 'redirect_uri/client'
require 'redirect_uri/discover'
require 'redirect_uri/request'

module RedirectUri
  def self.discover(url)
    Client.new(url).endpoints
  end
end
