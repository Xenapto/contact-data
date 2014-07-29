# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Link do
  let(:url) { 'http://iana.org' }

  it 'gets latest links with related slug' do
    VCR.use_cassette('links_latest') do
      result = ContactData::Link.latest verbose: true, since: '2014-07-28 12:12:20 +0100'
      expect(result).to be_an(Array)
    end
  end

  it 'gets metadata about a url' do
    VCR.use_cassette('links_info_search') do
      result = ContactData::Link.search url: url, verbose: true
      expect(result).to be_a(Hash)
    end
  end

  it 'gets metadata about a url when passed a url as a string' do
    VCR.use_cassette('links_info_search') do
      result = ContactData::Link.search url
      expect(result).to be_a(Hash)
    end
  end

  it 'gets metadata & contact from a url' do
    VCR.use_cassette('links_info_search') do
      result = ContactData::Link.info url: url, verbose: true
      expect(result).to be_a(Hash)
    end
  end
end
