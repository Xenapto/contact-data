# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Fetcher do
  let(:method) { 'method' }
  let(:url) { ContactData::Fetcher::URL }
  let(:url2) { 'http://example.com' }

  it 'adds diagnostic information to a RestClient exception' do
    RestClient::Request.any_instance.stub(:execute).and_raise RestClient::InternalServerError.new(nil, 500)

    expect { ContactData::Fetcher.get(method) }.to raise_error { |e|
      expect(e).to be_an(ContactData::FetchError)
      message = "500 Internal Server Error when trying to GET url: #{ContactData::Fetcher::URL}/#{method}.json"
      expect(e.message).to eq(message)
    }
  end

  it 'forms the expected URL' do
    [
      { method: method, options: {}, url: "#{url}/method.json" },
      { method: :method, options: {}, url: "#{url}/api/v2/method.json" },
      { method: :method, options: { base: 'base' }, url: "#{url}/api/v2/base/method.json" },
      { method: :method, options: { url_base: url2 }, url: "#{url2}/api/v2/method.json" }
    ].each do |url_data|
      puts "#{url_data[:method].class}\t#{url_data[:options]}"
      expect(
        ContactData::Fetcher.new(
          :get, url_data[:method], url_data[:options]
        ).url
      ).to eq(url_data[:url])
    end
  end
end
