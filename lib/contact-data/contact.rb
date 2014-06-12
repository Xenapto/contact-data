# encoding: utf-8
module ContactData
  class Contact
    class << self
      def search(name, options = {})
        options[:params] = { name: name }
        Fetcher.get(:search, options)
      end
    end
  end
end
