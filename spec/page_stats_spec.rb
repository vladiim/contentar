require 'spec_helper'

RSpec.describe PageStats do
  let(:url)     { URL }
  let(:subject) { PageStats.new(url) }

  before do
    allow(ENV).to receive(:[]) { 'ENV' }
    allow(ENV).to receive(:[]).with('PRICE_ACCESS_KEY') { 'ACCESS_KEY' }
  end

  describe '.new' do
    it 'stores the url' do
      expect(subject.url).to eq(url)
    end

    it 'knows the pricenomics api' do
      expect(PageStats::API).to eq('https://api.engine.priceonomics.com/v1/apps/')
    end

    it 'gets the access key from the ENV' do
      expect(subject.access_key).to be
    end
  end

  describe '#data' do
    context 'successful request', focus: true do
      it 'returns the page stats data' do
        stub_request(:post, MockPageStats.url).with(MockPageStats.mock_body_headers).to_return(MockPageStats.mock_return)
        allow(SocialPageStats).to receive(:new).with(any_args) { MockSocialPageStats.new }
        expect(subject.data).to eq(MockPageStats.data)
      end
    end

    context 'request time out' do
      it 'returns the error data' do
        stub_request(:post, MockPageStats.url).with(MockPageStats.mock_body_headers).to_timeout
        expect(subject.data).to eq(MockPageStats.error_data)
      end
    end
  end
end

class MockSocialPageStats
  def data
    MockPageStats.data
  end
end

class MockPageStats
  def self.data
    'DATA'
  end

  def self.url
    "#{ PageStats::API }social"
  end

  def self.mock_body_headers
    { body: "{\"async\":false,\"data\":{\"url\":\"http://www.example.com/\"}}",
      headers: {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'56', 'User-Agent'=>'Ruby', 'X-Access-Key'=>'ACCESS_KEY' } }
  end

  def self.mock_return
    { status: 200, body: data, headers: {} }
  end

  def self.json
    { 'data' => { 'stats' => data } }.to_json
  end

  def self.error_data
    { 'data' => { 'stats' => { error: 'request timeout' } } }.to_json
  end
end