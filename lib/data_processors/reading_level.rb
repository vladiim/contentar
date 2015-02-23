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
      composite_reading_level:      stats.fetch('composite'),
      ari_reading_level:            stats.fetch('ari'),
      coleman_liau_reading_level:   stats.fetch('coleman-liau'),
      flesch_kincaid_reading_level: stats.fetch('flesch-kincaid'),
      gunning_fog_reading_level:    stats.fetch('gunning-fog'),
      smog_reading_level:           stats.fetch('smog')
    }
  end
end