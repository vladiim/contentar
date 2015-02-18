require 'webmock/rspec'
require 'FileUtils'
require 'byebug'
require 'ostruct'
require_relative '../app.rb'

URL = 'http://www.example.com/'

def stub_url_request
  stub_request(:get, URL).with(mock_headers) { mock_return }
end

def mock_data
  [{ url: URL, title: nil }]
end

def mock_headers
  { headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby' } }
end

def mock_return
  { status: 200, body: OpenStruct.new(title: 'blah'), headers: {blah: 'lol'} }
end