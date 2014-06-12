# encoding: utf-8
module ContactData
  class Link
    BASE = :links

    class << self
      def latest(params = {})
        options = { base: BASE }

        options[:verbose] = params.delete(:verbose) if params.key? :verbose
        options[:params]  = params unless params.empty?

        Fetcher.get(:latest, options)
      end
    end
  end
end
