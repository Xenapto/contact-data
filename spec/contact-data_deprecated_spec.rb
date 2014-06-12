# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Deprecated do
  let(:name) { 'Derek Jones III' }

  context 'contact' do
    it 'searches by name' do
      VCR.use_cassette('deprecated_contact_search') do
        result = ContactData::Deprecated.search(name)
        expect(result).to be_a(Hash)
      end
    end
  end

  context 'contact name' do
    it 'finds contact names in text' do
      text = 'lorem ipsum john smith dolor sit amet'

      VCR.use_cassette('deprecated_contact_name_search') do
        result = ContactData::Deprecated.find_contacts_in(text)
        expect(result).to be_a(Hash)
      end
    end
  end

  context 'link' do
    it 'finds information about a url' do
      url = 'http://www.iana.org/numbers'

      VCR.use_cassette('deprecated_link_metadata') do
        result = ContactData::Deprecated.link_metadata(url)
        expect(result).to be_a(Hash)
      end
    end
  end
end
