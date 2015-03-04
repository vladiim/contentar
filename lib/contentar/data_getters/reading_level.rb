class ReadingLevelDataGetter < DataGetter
  def initialize(url)
    @url       = url
    @processor = ReadingLevelDataProcessor.new
    @api_call  = 'readinglevel'
    @values    = reading_values
    super
  end

  private

  def reading_values
    { async: false, data: { content: 'content' } }.to_json
  end
end