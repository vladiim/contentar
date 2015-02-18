class Spider
  attr_reader :base_path, :data
  def initialize(base_path)
    @base_path = base_path
    @data      = []
  end

  def get_data
    Spidr.site(base_path, ignore_links: ignored_links) do |site|
      get_site_data(site)
    end
  end

  private

  def ignored_links
    [/.js/, /.css/]
  end

  def get_site_data(site)
    site.every_page do |page|
      data << page_data(page)
    end
  end

  def page_data(page)
    { url: page.url.to_s, title: page.title }
  end
end