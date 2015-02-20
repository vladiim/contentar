require 'spec_helper'

RSpec.describe DataGetter do
  let(:subject) { DataGetter.new('URL') }

  before do
    allow(ENV).to receive(:[]) { 'ENV' }
    allow(ENV).to receive(:[]).with('PRICE_ACCESS_KEY') { 'ACCESS_KEY' }
  end

  describe '.new' do
    it 'stores the header' do
      expect(subject.headers).to eq({ x_access_key: 'ACCESS_KEY' })
    end
  end

  describe '#data' do

    before do
      subject.processor = MockProcessor.new
      subject.url       = MockDataGetter.url
      subject.api_call  = MockDataGetter.api_call
      subject.values    = MockDataGetter.values
    end

    context 'successful request' do

      before { stub_request(:post, MockDataGetter.url).with(MockDataGetter.values_headers).to_return(MockDataGetter.mock_return) }

      it 'returns the page stats data' do
        expect(subject.data).to eq('DATA')
      end
    end

    context 'request time out' do
      it 'returns the error data' do
        stub_request(:post, MockDataGetter.url).with(MockDataGetter.values_headers).to_timeout
        expect(subject.data).to eq(MockDataGetter.error_data)
      end
    end
  end
end

class MockProcessor
  def data(response_data)
    'DATA'
  end
end

class MockDataGetter
  def self.url
    "#{ PageStats::API }#{ api_call }"
  end

  def self.api_call
    'API_CALL'
  end

  def self.values_headers
    { body: values }.merge(headers)
  end

  def self.values
    { body: 'blah' }
  end

  def self.headers
    { :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'9', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby', 'X-Access-Key'=>'ACCESS_KEY'} }
  end

  def self.mock_return
    { status: 200, body: 'BODY', headers: {} }
  end

  def self.error_data
    { 'data' => { 'stats' => { error: 'request timeout' } } }.to_json
  end
end