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
      allow(PageStats).to receive(:new).with(MockCrawler.url) { MockPageStats.new }
      expect(subject.get_data).to eq(MockCrawler.updated_mock_data)
    end
  end
end

class MockPageStats
  def data
    MockCrawler.crawler_data
  end
end

class MockCrawler
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
    {
      stumbleupon_views: 0, reddit_submissions: 0,
      reddit_comments: 0, reddit_score: 0, google_plus_shares: 0,
      pinterest_shares: 0, twitter_shares: 0, linkedin_shares: 0,
      facebook_shares: 0, facebook_likes: 0, facebook_comments: 0
    }
  end
end