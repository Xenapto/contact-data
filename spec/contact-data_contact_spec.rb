# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Contact do
  let(:name) { 'Derek Jones III' }

  it 'searches for a contact by name' do
    VCR.use_cassette('name_search') do
      expect { ContactData::Contact.search(name, verbose: true) }.to raise_error(RestClient::ResourceNotFound)
    end
  end
end
