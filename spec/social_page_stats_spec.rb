require 'spec_helper'

RSpec.describe SocialPageStats do
  let(:data)    { MockSocialPageStats.data }
  let(:subject) { SocialPageStats.new(data) }

  describe '.new' do
    it 'saves the data' do
      expect(subject.json_data).to eq(data)
    end
  end

  describe '.data' do
    let(:processed_data) { MockSocialPageStats.processed_data }

    it 'returns the processed data' do
      expect(subject.data).to eq(processed_data)
    end
  end
end

class MockSocialPageStats

  def self.processed_data
    {
      stumbleupon_views: 0, reddit_submissions: 0,
      reddit_comments: 0,   reddit_score: 0, google_plus_shares: 0,
      pinterest_shares: 0,  twitter_shares: 0, linkedin_shares: 0,
      facebook_shares: 0,   facebook_likes: 0, facebook_comments: 0
    }
  end

  def self.data
    { 'data' => { 'stats' => {
      'stumbleupon' => { 'views'            => 0 },
      'reddit'      => { 'submission_count' => 0,
                         'comment_total'    => 0,
                         'score_total'      => 0 },
      'google+'     => { 'share_count'      => 0 },
      'pinterest'   => { 'share_count'      => 0 },
      'twitter'     => { 'share_count'      => 0 },
      'linkedin'    => { 'share_count'      => 0 },
      'facebook'    => { 'share_count'      => 0,
                         'like_count'       => 0,
                         'comment_count'    => 0 }
      }}
    }.to_json
  end
end