class ReadingLevelPageStats
  attr_reader :json_data, :stats
  def initialize(json_data)
    @json_data = json_data
    @stats     = JSON.parse(json_data).fetch('data')
  end

  def data
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