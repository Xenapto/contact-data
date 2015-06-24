# encoding: utf-8
require 'contact-data/contact'
require 'contact-data/link'
require 'contact-data/text'
require 'contact-data/fetcher'
require 'contact-data/deprecated'

class Hash
  def to_options(base, text = nil)
    o = { base: base }

    [:verbose, :url_base, :api_base, :format, :noformat].each { |k| o[k] = delete(k) if key?(k) }

    o[:payload] = { text: text } if text
    o[:params] = self unless empty?
    o
  end
end

require 'addressable/uri'

class String
  def encode_component
    Addressable::URI.encode_component(self, Addressable::URI::CharacterClasses::PATH)
  end

  def to_options(base)
    { url: self }.to_options(base)
  end
end
