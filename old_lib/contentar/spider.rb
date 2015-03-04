class Spider
  attr_reader :base_path, :data, :ignored_links
  def initialize(base_path)
    @base_path     = base_path
    @ignored_links = [/.js/, /.css/]
    @data          = []
  end

  def get_data
    get_site_data
    data
  end

  private

  def get_site_data
    Spidr.site(base_path, ignore_links: ignored_links) do |site|
      get_pages_data(site)
    end
  end

  def get_pages_data(site)
    site.every_page do |page|
      data << get_page_data(page)
    end
  end

  def get_page_data(page)
    { url: page.url.to_s, title: page.title }
  end
end