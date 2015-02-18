class PageStats
  API = 'https://api.engine.priceonomics.com/v1/apps/'

  attr_reader :url, :access_key
  def initialize(url)
    @url        = url
    @access_key = ENV['PRICE_ACCESS_KEY']
  end

  def data
    mock_data
  end

  def mock_data
    {
      stumbleupon_views: 0, reddit_submissions: 0,
      reddit_comments: 0, reddit_score: 0, google_plus_shares: 0,
      pinterest_shares: 0, twitter_shares: 0, linkedin_shares: 0,
      facebook_shares: 0, facebook_likes: 0, facebook_comments: 0#,
      # http://docs.analysisengine.apiary.io/#reference/detailed-examples/readinglevel
    }
  end
end