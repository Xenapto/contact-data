# encoding: utf-8
# frozen_string_literal: true
module ContactData
  class Identity
    BASE = :identities

    class << self
      def for_url(url, options = {})
        options[:base] ||= BASE
        options[:api_base] ||= 'api/v3'
        options[:params] ||= { url: url }

        Fetcher.get(:for_url, options)
      end
    end
  end
end
