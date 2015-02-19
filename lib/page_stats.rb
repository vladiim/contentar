class PageStats
  API = 'https://api.engine.priceonomics.com/v1/apps/'

  attr_reader :url, :access_key, :headers, :values
  def initialize(url)
    @url        = url
    @access_key = ENV['PRICE_ACCESS_KEY']
    @headers    = { x_access_key: access_key }
    @values     = { 'async' => false, 'data' => { 'url' => url } }
  end

  attr_reader :social_data
  def data
    social       = attempt_get_social_data
    @social_data = JSON.parse(social)['data']['stats']
    
  end

  private

  def attempt_get_social_data
    begin
      get_social_data
    rescue RestClient::RequestTimeout
      request_timeout_error_data
    end
  end

  def get_social_data
    RestClient.post("#{ API }social", values.to_json, headers)
  end

  def request_timeout_error_data
    { 'data' => { 'stats' => { error: 'request timeout' } } }.to_json
  end
end