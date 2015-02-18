require 'spec_helper'

RSpec.describe PageStats do
  let(:url)     { URL }
  let(:subject) { PageStats.new(url) }

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
    it 'returns the page stats data' do
      expect(subject.data).to eq(MockPageStats.data)
    end
  end
end

class MockPageStats
  def self.data
    {
      stumbleupon_views: 0, reddit_submissions: 0,
      reddit_comments: 0, reddit_score: 0, google_plus_shares: 0,
      pinterest_shares: 0, twitter_shares: 0, linkedin_shares: 0,
      facebook_shares: 0, facebook_likes: 0, facebook_comments: 0#,
      # http://docs.analysisengine.apiary.io/#reference/detailed-examples/readinglevel
    }
  end
end