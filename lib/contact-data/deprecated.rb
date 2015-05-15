# encoding: utf-8
require 'string'

module ContactData
  class Deprecated
    class << self
      def search(name, contact_type = nil)
        options = {}
        options[:params] = { contact_type: contact_type } if contact_type
        Fetcher.get("name/#{name.encode_component}", options)
      end

      def find_contacts_in(text)
        Fetcher.post('text/find_contacts', payload: { text: text }, timeout: 600)
      end

      def link_metadata(url)
        Fetcher.get("link/#{CGI.escape(url)}", noformat: true)
      end
    end
  end
end
