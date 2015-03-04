class SocialDataProcessor
  attr_reader :json_data, :stats

  def data(json_data)
    @json_data = json_data
    @stats     = get_stats
    process
  end

  private

  def process
    {
      stumbleupon_views: stumbleupon_views, reddit_submissions: reddit_submissions,
      reddit_comments: reddit_comments, reddit_score: reddit_score,
      google_plus_shares: google_plus_shares, pinterest_shares: pinterest_shares,
      twitter_shares: twitter_shares, linkedin_shares: linkedin_shares,
      facebook_shares: facebook_shares, facebook_likes: facebook_likes,
      facebook_comments: facebook_comments
    }
  end

  def get_stats
    dat = JSON.parse(json_data).fetch('data') { return {} }
    dat.fetch('stats') { return dat }
  end

  def reddit
    stats.fetch('reddit') { {} }
  end

  def google
    stats.fetch('google+') { {} }
  end

  def facebook
    stats.fetch('facebook') { {} }
  end

  def stumbleupon_views
    su = stats.fetch('stumbleupon') { return 0 }
    su.fetch('views') { return 0 }
  end

  def reddit_submissions
    reddit.fetch('submission_count') { 0 }
  end

  def reddit_comments
    reddit.fetch('comment_total') { 0 }
  end

  def reddit_score
    reddit.fetch('score_total') { 0 }
  end

  def google_plus_shares
    google.fetch('share_count') { 0 }
  end

  def pinterest_shares
    pinterest = stats.fetch('pinterest') { {} }
    pinterest.fetch('share_count') { 0 }
  end

  def twitter_shares
    twitter = stats.fetch('twitter') { {} }
    twitter.fetch('share_count') { 0 }
  end

  def linkedin_shares
    linkedin = stats.fetch('linkedin') { {} }
    linkedin.fetch('share_count') { 0 }
  end

  def facebook_shares
    facebook.fetch('share_count') { 0 }
  end

  def facebook_likes
    facebook.fetch('like_count') { 0 }
  end

  def facebook_comments
    facebook.fetch('comment_count') { 0 }
  end
end