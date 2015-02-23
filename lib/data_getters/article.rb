class ArticleDataGetter < DataGetter
  attr_reader :content

  def initialize(content)
    # @url       = ''
    @content   = content
    @processor = ArticleDataProcessor.new
    @api_call  = 'article'
    @values    = article_values
    super
  end

  private

  def article_values
    { async: false, data: { content: content, obey_robots: false } }.to_json
  end
end