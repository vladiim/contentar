class ContentPage
  attr_reader :json_data, :parsed_data
  def initialize(json_data)
    @json_data   = json_data
    @parsed_data = JSON.parse(json_data).fetch('data')
  end

  def data
    { content: parsed_data.fetch('content') }
  end
end