require 'spidr'
require 'dotenv'

Dir["#{ Dir.pwd }/lib/*"].each { |file| require file }

Dotenv.load

class App

  attr_reader :baseurl, :spider, :crawler
  def initialize(baseurl)
    @baseurl = baseurl
    @spider  = Spider.new(baseurl)
    spider.get_data
    @crawler = Crawler.new(spider.data)
  end

  def save_data
    DataSaver.csv(csv_filename, crawler.data)
  end

  private

  def csv_filename
    baseurl.gsub('http://', '').gsub('www.', '')
      .gsub('/', '') + '.csv'
  end
end