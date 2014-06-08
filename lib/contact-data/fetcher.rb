# encoding: utf-8
class ContactData
  class Fetcher
    URL = 'http://public.xenapto.com'
    API = 'api/v2'

    class << self
      [:get, :post].each do |http_method|
        define_method(http_method) do |api_method, options = {}|
puts options # debug
          url = get_url_from(api_method, options)
          fetch_and_parse url, http_method, options
        end
      end

      private

      def get_url_from(api_method, options = {})
        if api_method.is_a?(String)
          url = URI.escape("#{URL}/#{api_method}")
        elsif options[:base]
          url = "#{URL}/#{API}/#{options[:base]}/#{api_method}"
        else
          url = "#{URL}/#{API}/#{api_method}"
        end

        if options[:noformat]
          url
        else
          format = options[:format] || :json
          "#{url}.#{format}"
        end
      end

      def fetch_and_parse(url, method = :get, options = {})
        json = fetch(url, method, options)
        parse json
      end

      def fetch(url, method = :get, options = {})
        args = { url: url, method: method }
        args[:headers] = { params: options[:params] } if options.key? :params
        args[:payload] = options[:payload] if options.key? :payload
puts args # setup
        RestClient::Request.new(args).execute
      end

      def parse(json)
        JSON.parse(json, symbolize_names: true, allow_nan: true)
      end
    end
  end
end
