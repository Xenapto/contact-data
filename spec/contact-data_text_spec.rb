# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Text do
  let(:text) do
    <<-HTML
      <span style="font-family: -webkit-system-font, Helvetica Neue, Helvetica, sans-serif; color:rgba(0, 0, 0, 1.0);"
      class=""><b class="">From: </b></span>
      <span style="font-family: -webkit-system-font, Helvetica Neue, Helvetica, sans-serif;"
      class="">Max Williams<a href="mailto:max.williams@pusher-4.mail.intercom.io"
      class="">max.williams@pusher-4.mail.intercom.io</a>&gt;<br class=""></span>
    HTML
  end

  it 'gets metadata about text' do
    VCR.use_cassette('text_search') do
      result = ContactData::Text.search text, verbose: true
      expect(result).to be_a(Hash)
      expect(result[:contacts]).to include('neue')
      expect(result[:contacts]).not_to include('max-williams')
    end
  end

  it 'gets metadata about html, correctly identifying the text elements' do
    VCR.use_cassette('text_search') do
      result = ContactData::Text.search text, input_format: :html, verbose: true
      expect(result).to be_a(Hash)
      expect(result[:contacts]).not_to include('neue')
      expect(result[:contacts]).to include('max-williams')
    end
  end
end
