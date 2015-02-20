class ReadingLevelDataProcessor
  attr_reader :json_data, :stats

  def data(json_data)
    @json_data = json_data
    @stats     = JSON.parse(json_data).fetch('data')
    process
  end

  private

  def process
    {
      composite:      stats.fetch('composite'),
      ari:            stats.fetch('ari'),
      coleman_liau:   stats.fetch('coleman-liau'),
      flesch_kincaid: stats.fetch('flesch-kincaid'),
      gunning_fog:    stats.fetch('gunning-fog'),
      smog:           stats.fetch('smog')
    }
  end
end