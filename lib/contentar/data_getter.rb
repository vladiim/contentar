class DataGetter
  API = 'https://api.engine.priceonomics.com/v1/apps/'

  attr_accessor :processor, :url, :api_call, :values

  attr_reader :headers
  def initialize(url)
    @headers = { x_access_key: ENV['PRICE_ACCESS_KEY'] }
  end

  def data
    return error_process(response_data) if is_error?(response_data)
    processor.data(response_data)
  end

  private

  def response_data
    @response_data ||= attempt_get
  end

  def attempt_get
    begin
      get
    rescue RestClient::RequestTimeout, RestClient::InternalServerError => error
      error_data(error.message)
    end
  end

  def get
    RestClient.post("#{ API }#{ api_call }", values, headers)
  end

  def error_data(error)
    { error: error }.to_json
  end

  def is_error?(response)
    parsed = JSON.parse(response)
    parsed.fetch('error') { false }
  end

  def error_process(data)
    JSON.parse(data)
  end
end