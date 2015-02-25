class Crawler
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def get_data
    data.each_with_index.inject([]) do |updated_data, (page_data, index)|
      updated_data << get_page_data(page_data, index)
      updated_data
    end
  end

  private

  def get_page_data(page_data, index)
    progress_message(index, page_data.fetch(:title))
    page_stats = PageStats.new(page_data.fetch(:url))
    page_data.merge(get_page_stats(page_stats))
  end

  def progress_message(index, title)
    print "Fetching page #{ index }: \t\t#{ title.strip }\n"
  end

  def get_page_stats(page_stats)
    begin
      page_stats.data
    rescue Exception => e
      { error: e.message }
    end
  end
end