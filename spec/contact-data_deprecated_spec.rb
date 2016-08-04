# encoding: utf-8
# frozen_string_literal: true
describe ContactData::Deprecated do
  let(:name) { 'Derek Jones III' }
  let(:name_xml_bug) { 'XXXXXXXXXX ?' }

  context 'contact' do
    it 'searches by name' do
      VCR.use_cassette('deprecated_contact_search') do
        result = ContactData::Deprecated.search(name)
        expect(result).to be_a(Hash)
        expect(result[:count]).to eq(10)
      end
    end

    it 'searches by name with a contact type' do
      VCR.use_cassette('deprecated_contact_search') do
        result = ContactData::Deprecated.search(name, :person)
        expect(result).to be_a(Hash)
        expect(result[:count]).to eq(10)
      end
    end

    it 'searches successfully with name that gave XML bug' do
      VCR.use_cassette('deprecated_contact_search') do
        result = ContactData::Deprecated.search(name_xml_bug)
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
        expect(result[:contacts]).to eq(['lorem-ipsum', 'john-smith'])
      end
    end
  end

  context 'link' do
    it 'finds information about a url' do
      url = 'http://www.iana.org/numbers'

      VCR.use_cassette('deprecated_link_metadata') do
        result = ContactData::Deprecated.link_metadata(url)
        expect(result).to be_a(Hash)
        expect(result[:title]).to eq('IANA — Number Resources')
      end
    end
  end
end
