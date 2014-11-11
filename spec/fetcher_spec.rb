# encoding: utf-8
require 'spec_helper'
require 'contact-data'
require 'byebug'

describe ContactData::Fetcher do
  let(:method) { 'method' }

  it 'adds diagnostic information to a RestClient exception' do
    RestClient::Request.any_instance.stub(:execute).and_raise RestClient::InternalServerError.new(nil, 500)

    expect { ContactData::Fetcher.get(method) }.to raise_error { |e|
      expect(e).to be_an(ContactData::FetchError)
      message = "500 Internal Server Error when trying to GET url: #{ContactData::Fetcher::URL}/#{method}.json"
      expect(e.message).to eq(message)
    }
  end
end
