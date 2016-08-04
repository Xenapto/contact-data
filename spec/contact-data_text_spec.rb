# encoding: utf-8
# frozen_string_literal: true
require 'spec_helper'
require 'contact-data'

describe ContactData::Text do
  let(:text) do
    <<-HTML
      <span style="font-family: -webkit-system-font, Helvetica Neue, Helvetica, sans-serif; color:rgba(0, 0, 0, 1.0);"
      class=""><b class="">From: </b></span>
      <span style="font-family: -webkit-system-font, Helvetica Neue, Helvetica, sans-serif;"
      class="">Max Williams<a href="mailto:max.williams@example.com"
      class="">max.williams@example.com</a>&gt;<br class=""></span>
      <span>@maxwilliams</span>
    HTML
  end

  it 'gets metadata about text' do
    VCR.use_cassette('text_search') do
      result = ContactData::Text.search text, verbose: true
      expect(result).to be_a(ContactData::Text::Results)
      expect(result.slugs).to include('neue')
      expect(result.slugs_and_mentions).not_to include('max-williams')
      expect(result.emails).to include('max.williams@example.com')
    end
  end

  it 'gets metadata about html, correctly identifying the text elements' do
    VCR.use_cassette('text_search') do
      result = ContactData::Text.search text, input_format: :html, verbose: true
      expect(result).to be_a(ContactData::Text::Results)
      expect(result.slugs).not_to include('neue')
      expect(result.slugs_and_mentions).to include('max-williams', 'maxwilliams')
      expect(result.emails).to include('max.williams@example.com')
    end
  end

  it 'gets metadata about html, correctly identifying the text & title elements' do
    VCR.use_cassette('text_search') do
      result = ContactData::Text.search text, input_format: :html, verbose: true, title: 'Re: Sherry Coutu'
      expect(result).to be_a(ContactData::Text::Results)
      expect(result.slugs).not_to include('neue')
      expect(result.slugs_and_mentions).to include('max-williams', 'maxwilliams', 'sherry-coutu')
      expect(result.emails).to include('max.williams@example.com')
      expect(result.title_contact_slugs).to include('sherry-coutu')
      expect(result.title_contact_slugs).not_to include('max-williams')
    end
  end
end
