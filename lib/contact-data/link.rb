# encoding: utf-8
module ContactData
  class Link
    extend ContactData
    BASE = :links

    class << self
      def latest(params = {})
        Fetcher.get :latest, params.to_options(BASE)
      end

      def info(params = {})
        Fetcher.get :info, params.to_options(BASE)
      end

      def search(params = {})
        params[:timeout] ||= 600
        Fetcher.get :search, params.to_options(BASE)
      end
    end
  end
end
