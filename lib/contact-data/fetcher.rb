# encoding: utf-8
# frozen_string_literal: true
require 'logger'
require 'json'
require 'rest-client'
require 'contact-data/exception'

module ContactData
  class Fetcher
    attr_reader :http_method, :api_method, :options

    URL = ENV['XENDATA_URL'] || 'http://public.xenapto.com'
    API = 'api/v2'

    LOGLEVEL = Logger::WARN

    class << self
      [:get, :post].each do |http_method|
        define_method(http_method) do |api_method, options = {}|
          new(http_method, api_method, options).parsed_json
        end
      end
    end

    def parsed_json
      logger.info { "Parsing #{json.length} characters of JSON" }
      JSON.parse(json, symbolize_names: true, allow_nan: true)
    end

    def url
      return @url if @url
      @url = api_method.is_a?(String) ? "#{url_base}/#{api_method}" : "#{api_base}/#{method_base}#{api_method}"
      @url = "#{@url}.#{options[:format] || :json}" unless options[:noformat]
      @url
    end

    private

    def initialize(h, a, o = {})
      @http_method = h
      @api_method = a
      @options = o
      set_log_level
    end

    def url_base
      @url_base ||= (options[:url_base] || URL)
    end

    def api_base
      @api_base ||= "#{url_base}/#{options[:api_base] || API}"
    end

    def method_base
      @method_base ||= (options.key?(:base) ? "#{options[:base]}/" : '')
    end

    def display_method
      @display_method ||= http_method.to_s.upcase
    end

    def json
      return @json if @json
      logger.info { "Using #{display_method} for #{url}" }
      @json = RestClient::Request.new(args).execute
    rescue RestClient::Exception, SocketError, Net::HTTPBadGateway => e
      message = "#{e.message} when trying to #{display_method} url: #{url} with options #{options}"
      raise ContactData::FetchError, message, e.backtrace
    end

    def args
      return @args if @args

      @args = { url: url, method: http_method }
      @args[:headers] = { params: options[:params] } if options.key? :params

      [
        :method, :url, :headers, :cookies, :payload, :user, :password, :timeout, :max_redirects, :open_timeout,
        :raw_response, :processed_headers, :ssl_opts, :verify_ssl, :ssl_client_cert, :ssl_client_key, :ssl_ca_file,
        :ssl_ca_path, :ssl_cert_store, :ssl_verify_callback, :ssl_verify_callback_warnings, :ssl_version, :ssl_ciphers
      ].each { |key| @args[key] = options[key] if options.key? key } # TODO: surely this is just a merge?

      @args
    end

    def verbose?
      options[:verbose]
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def set_log_level
      logger.level = verbose? ? Logger::INFO : LOGLEVEL
    end
  end
end
