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

  context 'sibling class' do
    let(:sibling) { SiblingClass.new }

    describe '#data' do
      context 'successful request' do
        before { stub_request(:post, MockDataGetter.url).with(MockDataGetter.values_headers).to_return(MockDataGetter.mock_return) }

        it 'returns the page stats data' do
          expect(sibling.data).to eq(MockDataGetter.data)
        end
      end

      context 'request time out' do
        it 'returns the time out error data' do
          stub_request(:post, MockDataGetter.url).with(MockDataGetter.values_headers).to_timeout
          expect(sibling.data).to eq(MockDataGetter.error_data)
        end
      end

      context 'internal server error' do
        it 'returns the internal server error data' do
          stub_request(:post, MockDataGetter.url).with(MockDataGetter.values_headers).to_return(status: [500, "Internal Server Error"])
          expect(sibling.data).to eq(MockDataGetter.server_error_data)
        end
      end
    end
  end
end

class SiblingClass < DataGetter
  def initialize(url = 'URL')
    @url       = url
    @processor = MockProcessor.new
    @api_call  = MockDataGetter.api_call
    @values    = MockDataGetter.values
  end
end

class MockProcessor
  def data(response_data)
    MockDataGetter.data
  end
end

class MockDataGetter
  def self.url
    "#{ DataGetter::API }#{ api_call }"
  end

  def self.api_call
    'API_CALL'
  end

  def self.data
    { data: 'DATA' }.to_json
  end

  def self.values_headers
    { body: values }.merge(headers)
  end

  def self.values
    { body: 'blah' }
  end

  def self.headers
    { :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'9', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby' } }
  end

  def self.mock_return
    { status: 200, body: data, headers: {} }
  end

  def self.error_data
    { 'error' => 'Request Timeout' }
  end

  def self.server_error_data
    { 'error' => '500 Internal Server Error' }
  end
end