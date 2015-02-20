class SocialPageStats
  attr_reader :json_data, :stats
  def initialize(json_data)
    @json_data = json_data
    @stats     = JSON.parse(json_data).fetch('data').fetch('stats')
  end

  def data
    {
      stumbleupon_views: stumbleupon_views, reddit_submissions: reddit_submissions,
      reddit_comments: reddit_comments, reddit_score: reddit_score,
      google_plus_shares: google_plus_shares, pinterest_shares: pinterest_shares,
      twitter_shares: twitter_shares, linkedin_shares: linkedin_shares,
      facebook_shares: facebook_shares, facebook_likes: facebook_likes,
      facebook_comments: facebook_comments
   }
  end

  private

  def stumbleupon_views
    stats.fetch('stumbleupon').fetch('views')
  end

  def reddit_submissions
    stats.fetch('reddit').fetch('submission_count')
  end

  def reddit_comments
    stats.fetch('reddit').fetch('comment_total')
  end

  def reddit_score
    stats.fetch('reddit').fetch('score_total')
  end

  def google_plus_shares
    stats.fetch('google+').fetch('share_count')
  end

  def pinterest_shares
    stats.fetch('pinterest').fetch('share_count')
  end

  def twitter_shares
    stats.fetch('twitter').fetch('share_count')
  end

  def linkedin_shares
    stats.fetch('linkedin').fetch('share_count')
  end

  def facebook_shares
    stats.fetch('facebook').fetch('share_count')
  end

  def facebook_likes
    stats.fetch('facebook').fetch('like_count')
  end

  def facebook_comments
    stats.fetch('facebook').fetch('comment_count')
  end
end