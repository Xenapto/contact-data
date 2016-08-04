# encoding: utf-8
# frozen_string_literal: true
describe ContactData::Contact do
  let(:name) { 'Derek Jones III' }
  let(:source) { 'angel_list' }
  let(:slug) { 'derek-jones' }
  let(:domain) { 'anthemis.com' }

  it 'searches for a contact by name' do
    VCR.use_cassette('name_search') do
      result = ContactData::Contact.search name # , verbose: true
      expect(result).to be_a(Hash)
      expect(result[:slug]).to eq('derek-jones')
      expect(result[:identities].count).to eq(15)
    end
  end

  it 'retrieves a contact from a source' do
    VCR.use_cassette('source_slug') do
      result = ContactData::Contact.from source, slug # , verbose: true
      expect(result).to be_a(Hash)
      expect(result[:slug]).to eq(slug)
      expect(result[:data].first[:source_identities].count).to eq(5)
    end
  end

  it 'retrieves an organization contact from a domain name' do
    VCR.use_cassette('domain_name') do
      result = ContactData::Contact.from_domain domain # , verbose: true
      expect(result).to be_a(Hash)
      expect(result[:contacts].first[:slug]).to eq('anthemis-group')
      expect(result[:contacts].count).to eq(1)
    end
  end

  it 'retrieves a person contact from a domain name' do
    VCR.use_cassette('domain_name') do
      result = ContactData::Contact.from_domain domain, contact_type: 'person' # , verbose: true
      expect(result).to be_a(Hash)
      expect(result[:contacts].first[:slug]).to eq('sean-park')
      expect(result[:contacts].count).to eq(1)
    end
  end

  it 'retrieves all contacts for a domain name' do
    VCR.use_cassette('domain_name') do
      result = ContactData::Contact.from_domain domain, contact_type: 'all' # , verbose: true
      expect(result).to be_a(Hash)
      expect(result[:contacts].count).to eq(2)
    end
  end
end
