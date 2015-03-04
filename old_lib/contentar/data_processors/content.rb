class ContentDataProcessor
  attr_reader :json_data, :parsed_data

  def data(json_data)
    @json_data   = json_data
    @parsed_data = parse_data
    process
  end

  private

  def process
    content = parsed_data.fetch('content') { '' }
    { content: content }
  end

  def parse_data
    JSON.parse(json_data).fetch('data') { {} }
  end
end