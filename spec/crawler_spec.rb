require 'spec_helper'

RSpec.describe Crawler do
  let(:data)    { MockCrawler.mock_data }
  let(:subject) { Crawler.new(data) }

  describe '.new' do
    it 'stores the data' do
      expect(subject.data).to eq(data)
    end
  end

  describe '#get_data' do
    it 'returns updated data' do
      allow(PageStats).to receive(:new).with(MockCrawler.url) { MockCrawler::MockPageStats.new }
      expect(subject.get_data).to eq(MockCrawler.updated_mock_data)
    end
  end
end

module MockCrawler
  def self.url
    URL
  end

  def self.mock_data
    [{ url: url, title: "\r\nExample Domain\r\n" }]
  end

  def self.updated_mock_data
    [mock_data[0].merge(crawler_data)]
  end

  def self.crawler_data
    { data: 'DATA' }
  end

  class MockPageStats
    def data
      MockCrawler.crawler_data
    end
  end
end