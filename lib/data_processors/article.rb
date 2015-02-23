class ArticleDataProcessor
  attr_reader :json_data, :parsed_data

  def data(json_data)
    @json_data   = json_data
    @parsed_data = JSON.parse(json_data).fetch('data')
    process
  end

  private

  def process
    { article: parsed_data.fetch('content') }
  end
end