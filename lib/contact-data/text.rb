# encoding: utf-8
# frozen_string_literal: true
require 'contact-data/text/results'

module ContactData
  class Text
    BASE = :text

    class << self
      def search(text = nil, params = {})
        if params.is_a? Hash
          params[:timeout] ||= 600
          params[:api_base] ||= 'api/v3'
        end

        Results.new text, params
      end

      def common_phrase(raw_params = {})
        params = raw_params.is_a?(String) ? { name: raw_params } : raw_params
        params[:api_base] ||= 'api/v3'
        Fetcher.get :commmon_phrase, params.to_options(BASE)
      end
    end
  end
end
