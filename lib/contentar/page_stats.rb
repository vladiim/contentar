class PageStats

  attr_reader :url
  def initialize(url)
    @url = url
  end

  def data
    social_data.
      merge(reading_level_data).
      merge(article_data).
      merge(word_count_data)
  end

  private

  def social_data
    @social_data ||= SocialDataGetter.new(url).data
  end

  def reading_level_data
    @reading_level_data ||= ReadingLevelDataGetter.new(url).data
  end

  def content_data
    @content_data ||= ContentDataGetter.new(url).data
  end

  def article_data
    content = content_data.fetch(:content) { '' }
    @article_data ||= ArticleDataGetter.new(content).data
  end

  def word_count_data
    article = article_data.fetch(:article) { '' }
    { word_count: article.length }
  end
end