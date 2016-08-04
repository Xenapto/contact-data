# encoding: utf-8
# frozen_string_literal: true
describe ContactData::Identity do
  it 'retrieves an organization contact from a url name' do
    VCR.use_cassette('identity') do
      result = ContactData::Identity.for_url 'http://xenapto.com' # , verbose: true
      expect(result).to be_a(Hash)
      expect(result[:stale]).to be_falsey
      expect(result[:identities].count).to eq(2)
    end
  end
end
