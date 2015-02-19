class Crawler
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def get_data
    data.each_with_index.inject([]) do |updated_data, (page_data, index)|
      print "Fetching page ##{ index }: #{ page_data.fetch(:title) }"
      page_stats = PageStats.new(page_data.fetch(:url))
      updated_data << page_data.merge(page_stats.data)
      updated_data
    end
  end
end