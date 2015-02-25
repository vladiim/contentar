class ReadingLevelDataProcessor
  attr_reader :json_data, :parsed_data

  def data(json_data)
    @json_data   = json_data
    @parsed_data = parse_data
    process
  end

  private

  def process
    {
      composite_reading_level:      composite,
      ari_reading_level:            ari,
      coleman_liau_reading_level:   coleman_liau_reading_level,
      flesch_kincaid_reading_level: flesch_kincaid_reading_level,
      gunning_fog_reading_level:    gunning_fog_reading_level,
      smog_reading_level:           smog_reading_level
    }
  end

  def parse_data
    JSON.parse(json_data).fetch('data') { {} }
  end

  def composite
    parsed_data.fetch('composite') { 0 }
  end

  def ari
    parsed_data.fetch('ari') { 0 }
  end

  def coleman_liau_reading_level
    parsed_data.fetch('coleman-liau') { 0 }
  end

  def flesch_kincaid_reading_level
    parsed_data.fetch('flesch-kincaid') { 0 }
  end

  def gunning_fog_reading_level
    parsed_data.fetch('gunning-fog') { 0 }
  end

  def smog_reading_level
    parsed_data.fetch('smog') { 0 }
  end
end