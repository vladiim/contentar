class ContentDataGetter < DataGetter
  def initialize(url)
    @url       = url
    @processor = ContentDataProcessor.new
    @api_call  = 'fetch'
    @values    = content_values
    super
  end

  private

  def content_values
    { async: false, data: { url: url, obey_robots: false } }.to_json
  end
end