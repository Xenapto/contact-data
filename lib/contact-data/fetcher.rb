# encoding: utf-8
require 'rest-client'

module ContactData
  class Fetcher
    URL = 'http://public.xenapto.com'
    API = 'api/v2'

    LOGLEVEL = Logger::WARN

    class << self
      [:get, :post].each do |http_method|
        define_method(http_method) do |api_method, options = {}|
          log_level(options)
          url = get_url_from(api_method, options)
          result = fetch_and_parse url, http_method, options
          log_level(LOGLEVEL)
          result
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
        logger.info { "Parsing #{json.length} characters of JSON" }
        parse json
      end

      def fetch(url, method = :get, options = {})
        logger.info { "Using #{method.to_s.upcase} for #{url}" }
        args = { url: url, method: method }
        args[:headers] = { params: options[:params] } if options.key? :params

        %i(
          method url headers cookies payload user password timeout
          max_redirects open_timeout raw_response processed_headers args
          ssl_opts verify_ssl ssl_client_cert ssl_client_key ssl_ca_file
          ssl_ca_path ssl_cert_store ssl_verify_callback
          ssl_verify_callback_warnings ssl_version ssl_ciphers
        ).each { |key| args[key] = options[key] if options.key? key }

        RestClient::Request.new(args).execute
      end

      def parse(json)
        JSON.parse(json, symbolize_names: true, allow_nan: true)
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def log_level(options = {})
        logger.level =  if options.is_a?(Hash)
                          options[:verbose] ? Logger::INFO : LOGLEVEL
                        else
                          options
                        end
      end
    end
  end
end
