# encoding: utf-8
module ContactData
  class Text
    extend ContactData
    BASE = :text

    def self.search(text = nil, params = {})
      params[:timeout] ||= 600 if params.is_a? Hash
      Fetcher.post :search, params.to_options(BASE, text)
    end
  end
end
