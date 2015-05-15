# encoding: utf-8
module ContactData
  class Text
    extend ContactData
    BASE = :text

    def self.search(text = nil, params = {})
      Fetcher.post :search, params.to_options(BASE, text)
    end
  end
end
