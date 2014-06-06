# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Deprecated do
  let(:name) { 'Derek Jones III' }

  it 'searches for a contact by name' do
    result = ContactData::Deprecated.search(name)
    expect(result).to be_a(String)
  end
end
