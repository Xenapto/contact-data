# encoding: utf-8
require 'contact-data/text/results'

module ContactData
  class Text
    def self.search(text = nil, params = {})
      if params.is_a? Hash
        params[:timeout] ||= 600
        params[:api_base] ||= 'api/v3'
      end

      Results.new text, params
    end
  end
end
