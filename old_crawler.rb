require 'rest_client'
require 'json'
require 'csv'
require 'byebug'
# Use:
# urls = %w( array of urls )
# crawler = Crawler.new(urls)
# crawler.get_and_write_data

# change the directory or filename of the output file
# crawler.get_and_write_data(new_dirname, new_filename)

class Crawler
  COL_NAMES = %w(url stumbleupon_views reddit_submissions reddit_comments reddit_score google_plus_shares pinterest_shares twitter_shares linkedin_shares facebook_shares facebook_likes facebook_comments)

  attr_reader :urls, :keys, :table

  def initialize(urls)
    @urls = urls
    @keys  = CSV::Row.new(COL_NAMES,[ ], true)
    @table = CSV::Table.new([keys])
  end

  def get_and_write_data(filename = 'test.csv', dir = Dir.pwd)
    file = "#{ dir }/#{ filename }"
    get_data
    return if all_data.empty?
    add_data_to_table
    write_data(filename)
  end

  attr_reader :all_data

  private

  def get_data
    @all_data = urls.inject([]) do |data_array, url|
      sc = SocialCount.new(url)
      print "Scanning url: #{ url } \n"
      catch(:no_data) do
        data = { url: url }.merge(sc.data)
        unless data_array.nil?
          data_array << data
          data_array
        end
      end
    end
  end

  def add_data_to_table
    all_data.each do |data|
      row = CSV::Row.new([], [], false)
      COL_NAMES.each { |key| row << data[key.to_sym] }
      table << row
    end
  end

  def write_data(filename)
    CSV.open(filename, 'w', write_headers: true, headers: COL_NAMES) do |writer|
      table.each { |row| writer << row }
    end
  end
end

class SocialCount
  attr_reader :access_key, :url, :api
  def initialize(url)
    @access_key = ENV['PRICE_ACCESS_KEY']
    @url = url
    @api = 'https://api.engine.priceonomics.com/v1/apps/'
  end

  def get
    begin
      @res ||= RestClient.post("#{ api }social", values.to_json, headers)
      JSON.parse(@res)
    rescue RestClient::RequestTimeout
      @res ||= { 'stumbleupon' => { 'views' => 0 },
                 'reddit'      => { 'submission_count' => 0,
                                    'comment_total' => 0,
                                    'score_total' => 0 },
                  'google+'    => { 'share_count' => 0 },
                  'pinterest'  => { 'share_count' => 0 },
                  'twitter'    => { 'share_count' => 0 },
                  'linkedin'   => { 'share_count' => 0 },
                  'facebook'   => { 'share_count' => 0,
                                    'like_count' => 0,
                                    'comment_count' => 0 } }
      throw :no_data
    end
  end

  def data
    {
      stumbleupon_views: stumbleupon_views, reddit_submissions: reddit_submissions,
      reddit_comments: reddit_comments, reddit_score: reddit_score, google_plus_shares: google_plus_shares,
      pinterest_shares: pinterest_shares, twitter_shares: twitter_shares, linkedin_shares: linkedin_shares,
      facebook_shares: facebook_shares, facebook_likes: facebook_likes, facebook_comments: facebook_comments
    }
  end

  private

  def stumbleupon_views
    @stumbleupon_views ||= stats['stumbleupon']['views']
  end

  def reddit_submissions
    @reddit_submissions ||= stats['reddit']['submission_count']
  end

  def reddit_comments
    @reddit_comments ||= stats['reddit']['comment_total']
  end

  def reddit_score
    @reddit_score ||= stats['reddit']['score_total']
  end

  def google_plus_shares
    @google_plus_shares ||= stats['google+']['share_count']
  end

  def pinterest_shares
    @pinterest_shares ||= stats['pinterest']['share_count']
  end

  def twitter_shares
    @twitter_shares ||= stats['twitter']['share_count']
  end

  def linkedin_shares
    @linkedin_shares ||= stats['linkedin']['share_count']
  end

  def facebook_shares
    @facebook_shares ||= stats['facebook']['share_count']
  end

  def facebook_likes
    @facebook_likes ||= stats['facebook']['like_count']
  end

  def facebook_comments
    @facebook_comments ||= stats['facebook']['comment_count']
  end

  def stats
    @stats ||= get['data']['stats']
  end

  def headers
    @headers ||= { x_access_key: access_key }
  end

  def values
    @values ||= { 'async' => false, 'data' => { 'url' => url } }
  end
end