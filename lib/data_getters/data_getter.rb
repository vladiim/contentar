class DataGetter
  API = 'https://api.engine.priceonomics.com/v1/apps/'

  attr_accessor :processor, :url, :api_call, :values

  attr_reader :headers
  def initialize(url)
    @headers = { x_access_key: ENV['PRICE_ACCESS_KEY'] }
  end

  def data
    return request_timeout_error_data if response_data == request_timeout_error_data
    processor.data(response_data)
  end

  private

  def response_data
    @response_data ||= attempt_get
  end

  def attempt_get
    begin
      get
    rescue RestClient::RequestTimeout
      request_timeout_error_data
    end
  end

  def get
    RestClient.post("#{ API }#{ api_call }", values, headers)
  end

  def request_timeout_error_data
    { 'data' => { 'stats' => { error: 'request timeout' } } }.to_json
  end
end