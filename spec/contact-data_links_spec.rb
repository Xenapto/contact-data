# encoding: utf-8
require 'spec_helper'
require 'contact-data'

describe ContactData::Links do
  it 'gets latest links with related slug' do
    result = ContactData::Links.latest
    expect(result).to be_a(String)
  end
end
