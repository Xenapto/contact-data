# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Deprecated do
  let(:name) { 'Derek Jones III' }

  it 'searches for a contact by name' do
    result = ContactData::Deprecated.search(name)
    expect(result).to be_a(Hash)
  end

  it 'finds contact names in text' do
    text = 'lorem ipsum john smith dolor sit amet'
    result = ContactData::Deprecated.find_contacts_in(text)
    expect(result).to be_a(Hash)
  end

  it 'finds information about a url' do
    url = 'http://www.iana.org/numbers'
    result = ContactData::Deprecated.link_metadata(url)
    expect(result).to be_a(Hash)
  end
end
