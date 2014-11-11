# encoding: utf-8
module ContactData
  class Contact
    BASE = :contacts

    class << self
      def search(name, options = {})
        options[:base] = BASE
        options[:params] = { name: name }
        Fetcher.get(:search, options)
      end
    end
  end
end
