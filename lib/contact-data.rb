# encoding: utf-8
require 'contact-data/links'
require 'contact-data/fetcher'
require 'contact-data/deprecated'

class ContactData
  class << self
    def search(name)
      Fetcher.get(:search, params: { name: name })
    end
  end
end
