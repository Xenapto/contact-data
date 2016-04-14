# encoding: utf-8
module ContactData
  class Contact
    BASE = :contacts

    class << self
      def search(name, options = {})
        options[:base] ||= BASE
        options[:params] ||= { name: name }
        Fetcher.get(:search, options)
      end

      def from(source, slug, options = {})
        options[:base] ||= BASE
        options[:params] ||= { source: source, slug: slug }
        Fetcher.get(:from, options)
      end

      def from_domain(domain, options = {})
        explicit_contact_type = options.delete(:contact_type)

        options[:base] ||= BASE
        options[:api_base] ||= 'api/v3'
        options[:params] ||= { domain: domain }
        options[:params][:contact_type] ||= explicit_contact_type if explicit_contact_type

        Fetcher.get(:from_domain, options)
      end
    end
  end
end
