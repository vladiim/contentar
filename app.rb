require 'spidr'
require 'json'
require 'csv'
require 'rest-client'
require 'dotenv'

autoload(:DataGetter, './lib/data_getters/data_getter.rb')

Dir["#{ Dir.pwd }/lib/**/*.rb"].each { |file| require file }


Dotenv.load

class App

  attr_reader :baseurl, :spider, :crawler, :saver
  def initialize(baseurl)
    @baseurl = baseurl
    @spider  = Spider.new(baseurl)
    @crawler = Crawler.new(spider.get_data)
  end

  def save_data
    DataSaver.csv(csv_filename, crawler.get_data)
  end

  private

  def csv_filename
    baseurl.gsub('http://', '').gsub('www.', '')
      .gsub('/', '')
  end
end