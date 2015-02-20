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

  # describe '#social_data' do
  #   context 'successful request' do
  #     it 'returns the page stats data' do
  #       stub_request(:post, MockPageStats.social_url).with(MockPageStats.mock_social_body_headers).to_return(MockPageStats.mock_return)
  #       allow(SocialPageStats).to receive(:new).with(any_args) { MockSocialPageStats.new }
  #       expect(subject.social_data).to eq(MockPageStats.data)
  #     end
  #   end

  #   context 'request time out' do
  #     it 'returns the error data' do
  #       stub_request(:post, MockPageStats.social_url).with(MockPageStats.mock_social_body_headers).to_timeout
  #       expect(subject.social_data).to eq(MockPageStats.error_data)
  #     end
  #   end
  # end

  # describe '#reading_level_data' do
  #   context 'successful request' do
  #     it 'returns the page reading data' do
  #       stub_request(:post, MockPageStats.reading_url).with(MockPageStats.mock_reading_body_headers).to_return(MockPageStats.mock_return)
  #       allow(ReadingLevelPageStats).to receive(:new).with(any_args) { MockReadingLevelPageStats.new }
  #       expect(subject.reading_level_data).to eq(MockPageStats.data)
  #     end
  #   end

  #   context 'request time out' do
  #     it 'returns the error data' do
  #       stub_request(:post, MockPageStats.reading_url).with(MockPageStats.mock_reading_body_headers).to_timeout
  #       expect(subject.reading_level_data).to eq(MockPageStats.error_data)
  #     end
  #   end
  # end

  # describe '#content_data' do
  #   context 'successful request' do
  #     it 'returns the page content data' do
  #       stub_request(:post, MockPageStats.content_url).with(MockPageStats.mock_content_body_headers).to_return(MockPageStats.mock_return)
  #       allow(ContentPage).to receive(:new).with(any_args) { MockContentPage.new }
  #       expect(subject.content_data).to eq(MockPageStats.data)
  #     end
  #   end

  #   context 'request time out' do
  #     it 'returns the error data' do
  #       stub_request(:post, MockPageStats.content_url).with(MockPageStats.mock_content_body_headers).to_timeout
  #       expect(subject.content_data).to eq(MockPageStats.error_data)
  #     end
  #   end
  # end
end

class MockSocialPageStats
  def data
    MockPageStats.data
  end
end

class MockReadingLevelPageStats
  def data
    MockPageStats.data
  end
end

class MockContentPage
  def data
    MockPageStats.data
  end
end

class MockPageStats
  def self.data
    'DATA'
  end

  # def self.social_url
  #   "#{ PageStats::API }social"
  # end

  def self.reading_url
    "#{ PageStats::API }readinglevel"
  end

  def self.content_url
    "#{ PageStats::API }fetch"
  end

  # def self.mock_social_body_headers
  #   { body: "{\"async\":false,\"data\":{\"url\":\"http://www.example.com/\"}}",
  #     headers: {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'56', 'User-Agent'=>'Ruby', 'X-Access-Key'=>'ACCESS_KEY' } }
  # end

  def self.mock_reading_body_headers
    { body: "{\"async\":false,\"data\":{\"content\":\"content\"}}",
      headers: { 'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'44', 'User-Agent'=>'Ruby', 'X-Access-Key'=>'ACCESS_KEY' } }
  end

  def self.mock_content_body_headers
    { body: "{\"async\":false,\"data\":{\"url\":\"http://www.example.com/\",\"obey_robots\":false}}",
      headers: { 'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'76', 'User-Agent'=>'Ruby', 'X-Access-Key'=>'ACCESS_KEY' } }
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