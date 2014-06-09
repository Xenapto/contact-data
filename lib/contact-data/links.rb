# encoding: utf-8
class ContactData
  # Link methods
  class Links
    BASE = :links

    class << self
      def latest(params = {})
        Fetcher.get(:latest, base: BASE, params: params)
      end
    end
  end
end
