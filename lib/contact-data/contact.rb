# encoding: utf-8
module ContactData
  class Contact
    class << self
      def search(name, options = {})
        options[:params] = { name: name }
        options[:timeout] ||= 90 # seconds
        Fetcher.get(:search, options)
      end
    end
  end
end
