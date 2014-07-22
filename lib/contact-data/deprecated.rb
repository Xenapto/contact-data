# encoding: utf-8
module ContactData
  class Deprecated
    class << self
      def search(name)
        Fetcher.get("name/#{name}")
      end

      def find_contacts_in(text)
        Fetcher.post('text/find_contacts', payload: { text: text }, timeout: 180)
      end

      def link_metadata(url)
        Fetcher.get("link/#{CGI.escape(url)}", noformat: true)
      end
    end
  end
end
