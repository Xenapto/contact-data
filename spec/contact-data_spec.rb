# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData do
  let(:name) { 'Derek Jones III' }

  it 'searches for a contact by name' do
    expect{ ContactData.search(name) }.to raise_error(RestClient::ResourceNotFound)
  end
end
