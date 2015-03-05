class Contentar

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

require 'spidr'
require 'json'
require 'csv'
require 'rest-client'
require 'dotenv'

Dotenv.load

# Dir["#{Dir.pwd}/lib/contentar/**/*.rb"].each { |f| require f }

#-------------
# TOP LEVEL
#-------------
autoload(:Spider,                    'contentar/spider')
autoload(:Crawler,                   'contentar/crawler')
autoload(:PageStats,                 'contentar/page_stats')
autoload(:DataSaver,                 'contentar/data_saver')
autoload(:DataGetter,                'contentar/data_getter')

#-------------
# DATA GETTERS
#-------------
autoload(:ArticleDataGetter,         'contentar/data_getters/article')
autoload(:ContentDataGetter,         'contentar/data_getters/content')
autoload(:ReadingLevelDataGetter,    'contentar/data_getters/reading_level')
autoload(:SocialDataGetter,          'contentar/data_getters/social')

#-------------
# DATA PROCESSORS
#-------------
autoload(:ArticleDataProcessor,      'contentar/data_processors/article')
autoload(:ContentDataProcessor,      'contentar/data_processors/content')
autoload(:ReadingLevelDataProcessor, 'contentar/data_processors/reading_level')
autoload(:SocialDataProcessor,       'contentar/data_processors/social')