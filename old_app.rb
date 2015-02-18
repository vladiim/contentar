require_relative 'crawler.rb'
require 'rest-client'
require 'json'
require 'spidr'
require 'csv'
require 'dotenv'
require 'byebug'

Dotenv.load

# ["#{ Dir.pwd }/lib/*"].each { |file| require file }

class App
  attr_reader :spider, :crawler
  def initialize(base_path ='http://audibrandexperience.com.au/')
    @spider = SiteSpider.new(base_path)
    @crawler = Crawler.new(@spider.urls_to_s)
  end

  def save_data
    crawler.get_and_write_data(filename = "#{unurl(crawler.urls[0])}.csv")
  end

  private

  def unurl(url)
    url.gsub('.', '-').gsub('http://', '').gsub('/', '')
  end
end

class SiteSpider
  attr_reader :base_path
  def initialize(base_path)
    @base_path = base_path
  end

  def urls
    @urls ||= get_urls
  end

  def urls_to_s
    urls.map { |url| url.to_s }
  end

  # private

  def get_urls
    urls = []
    pages = []
    Spidr.site(base_path, ignore_links: [/.js/, /.css/]) do |spidr|
      spidr.every_url { |url| urls << url }
      spidr.every_page do |page|
        page.url
        page.title
      end
    end

    urls
  end
end