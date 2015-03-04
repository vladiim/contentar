class SocialDataGetter < DataGetter
  def initialize(url)
    @url       = url
    @processor = SocialDataProcessor.new
    @api_call  = 'social'
    @values    = { 'async' => false, 'data' => { 'url' => url } }.to_json
    super
  end
end