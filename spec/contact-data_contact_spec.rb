# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Contact do
  let(:name) { 'Derek Jones III' }
  let(:source) { 'angel_list' }
  let(:slug) { 'derek-jones' }

  it 'searches for a contact by name' do
    VCR.use_cassette('name_search') do
      result = ContactData::Contact.search(name, verbose: true)
      expect(result).to be_a(Hash)
      expect(result[:slug]).to eq('derek-jones')
      expect(result[:identities].count).to eq(15)
    end
  end

  it 'retrieves a contact from a source' do
    VCR.use_cassette('source_slug') do
      result = ContactData::Contact.from(source, slug, verbose: true)
      expect(result).to be_a(Hash)
      expect(result[:slug]).to eq(slug)
      expect(result[:data].first[:source_identities].count).to eq(5)
    end
  end
end
