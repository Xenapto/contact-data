# encoding: utf-8
class ContactData
  class Fetcher
    URL = 'http://public.xenapto.com'
    API = 'api/v2'

    class << self
      def get(api_method, options = {})
        url = get_url_from(api_method, options)
puts url # debug
        RestClient.get url, options[:params]
      end

      private

      def get_url_from(api_method, options = {})
        if api_method.is_a?(String)
          URI.escape("#{URL}/#{api_method}")
        elsif options[:base]
          "#{URL}/#{API}/#{options[:base]}/#{api_method}"
        else
          "#{URL}/#{API}/#{api_method}"
        end
      end
    end
  end
end
