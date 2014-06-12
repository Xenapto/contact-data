# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Link do
  it 'gets latest links with related slug' do
    VCR.use_cassette('links_latest') do
      result = ContactData::Link.latest verbose: true
      expect(result).to be_an(Array)
    end
  end
end
