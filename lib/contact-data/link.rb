# encoding: utf-8
module ContactData
  class Link
    BASE = :links

    class << self
      def latest(params = {})
        Fetcher.get :latest, options_from(params)
      end

      def info(params = {})
        Fetcher.get :info, options_from(params)
      end

      def search(params = {})
        Fetcher.get :search, options_from(params)
      end

      private

      def options_from(params = {})
        options = { base: BASE }

        options[:verbose] = params.delete(:verbose) if params.key? :verbose
        options[:params]  = params unless params.empty?
        options
      end
    end
  end
end