# encoding: utf-8
require 'rest-client'
require 'contact-data/exception'

module ContactData
  class Fetcher
    URL = ENV['XENDATA_URL'] || 'http://public.xenapto.com'
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

      def encode_component(string)
        Addressable::URI.encode_component(string, Addressable::URI::CharacterClasses::PATH)
      end

      private

      def get_url_from(api_method, options = {})
        if api_method.is_a?(String)
          url = "#{URL}/#{api_method}"
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
        args = args_from url, method, options

        begin
          RestClient::Request.new(args).execute
        rescue RestClient::Exception => e
          raise ContactData::FetchError, "#{e.message} when trying to #{method.to_s.upcase} url: #{url}", e.backtrace
        end
      end

      def args_from(url, method, options)
        args = { url: url, method: method }
        args[:headers] = { params: options[:params] } if options.key? :params

        [
          :method, :url, :headers, :cookies, :payload, :user, :password, :timeout,
          :max_redirects, :open_timeout, :raw_response, :processed_headers,
          :ssl_opts, :verify_ssl, :ssl_client_cert, :ssl_client_key, :ssl_ca_file,
          :ssl_ca_path, :ssl_cert_store, :ssl_verify_callback,
          :ssl_verify_callback_warnings, :ssl_version, :ssl_ciphers
        ].each { |key| args[key] = options[key] if options.key? key }

        args
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
