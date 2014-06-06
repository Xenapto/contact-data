# encoding: utf-8
class ContactData
  class Deprecated
    class << self
      def search(name)
        Fetcher.get("name/#{name}.json")
      end
    end
  end
end
