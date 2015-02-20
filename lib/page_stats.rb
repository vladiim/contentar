class PageStats
  API = 'https://api.engine.priceonomics.com/v1/apps/'

  attr_reader :url, :access_key, :headers, :values
  def initialize(url)
    @url        = url
    @access_key = ENV['PRICE_ACCESS_KEY']
    @headers    = { x_access_key: access_key }
    @values     = { 'async' => false, 'data' => { 'url' => url } }.to_json
  end

  def data
    social_data.merge(reading_level_data).merge(content_data)
  end

  def social_data
    @social_data ||= SocialDataGetter.new(url).data
    # @social_data ||= social_page_stats(attempt_get_social_data)
  end

  def reading_level_data
    @reading_level_data ||= reading_level_page_stats(attempt_get_reading_data)
  end

  def content_data
    @content_data ||= content_page_data(attempt_get_content_data)
  end

  # def article_data
  #   @article_data ||= 
  # end

  private

  # def social_page_stats(data)
  #   return data if data == request_timeout_error_data
  #   SocialPageStats.new(data).data
  # end

  def reading_level_page_stats(data)
    return data if data == request_timeout_error_data
    ReadingLevelPageStats.new(data).data
  end

  def content_page_data(data)
    return data if data == request_timeout_error_data
    ContentPage.new(data).data
  end

  # def attempt_get_social_data
  #   begin
  #     get_social_data
  #   rescue RestClient::RequestTimeout
  #     request_timeout_error_data
  #   end
  # end

  def attempt_get_reading_data
    begin
      get_reading_data
    rescue RestClient::RequestTimeout
      request_timeout_error_data
    end
  end

  def attempt_get_content_data
    begin
      get_content_data
    rescue RestClient::RequestTimeout
      request_timeout_error_data
    end
  end

  # def get_social_data
  #   RestClient.post("#{ API }social", values, headers)
  # end

  def get_reading_data
    RestClient.post("#{ API }readinglevel", reading_values, headers)
  end

  def get_content_data
    RestClient.post("#{ API }fetch", content_values, headers)
  end

  def reading_values
    {
        async: false,
        data: {
            content: 'content',
        }
    }.to_json
  end

  def content_values
    {
      async: false,
      data: {
        url: url,
        obey_robots: false
      }
    }.to_json
  end

  def request_timeout_error_data
    { 'data' => { 'stats' => { error: 'request timeout' } } }.to_json
  end
end