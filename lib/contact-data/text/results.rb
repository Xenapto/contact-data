# frozen_string_literal: true
module ContactData
  class Text
    class Results
      extend ContactData

      attr_reader :text, :params, :raw

      def initialize(t, p = {})
        @text = t
        @params = p

        @raw = Fetcher.post :search, params.to_options(Text::BASE, text)
      end

      def contacts
        @contacts ||= raw[:contacts]
      end

      def emails
        @emails ||= raw[:emails]
      end

      def slugs
        @slugs ||= contacts.map { |c| c[:slug] }
      end

      def uncommon_slugs
        @slugs ||= contacts.select { |c| c[:common_phrase] == true }.map { |c| c[:slug] }
      end

      def mentions
        @mentions ||= raw[:mentions]
      end

      def slugs_and_mentions
        @slugs_and_mentions ||= (slugs | mentions)
      end

      def uncommon_slugs_and_mentions
        @slugs_and_mentions ||= (uncommon_slugs | mentions)
      end

      def title_contacts
        @title_contacts ||= contacts.select { |c| c[:in_title] }
      end

      def title_contact_slugs
        @title_contact_slugs ||= title_contacts.map { |c| c[:slug] }
      end
    end
  end
end
