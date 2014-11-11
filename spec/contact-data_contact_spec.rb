# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Contact do
  let(:name) { 'Derek Jones III' }

  it 'searches for a contact by name' do
    VCR.use_cassette('name_search') do
      result = ContactData::Contact.search(name, verbose: true)
      expect(result).to be_a(Hash)
      expect(result[:slug]).to eq('derek-jones')
      expect(result[:identities].count).to eq(15)
    end
  end
end
