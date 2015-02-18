class Crawler
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def get_data
    data.each.inject([]) do |updated_data, page_data|
      page_stats = PageStats.new(page_data.fetch(:url))
      updated_data << page_data.merge(page_stats.data)
      updated_data
    end
  end
end