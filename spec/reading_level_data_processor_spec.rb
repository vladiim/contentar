require 'spec_helper'

RSpec.describe ReadingLevelDataProcessor do
  let(:subject) { ReadingLevelDataProcessor.new }

  describe '.data' do
    let(:data)           { MockReadingLevelDataProcessor.data }
    let(:processed_data) { MockReadingLevelDataProcessor.processed_data }

    it 'returns the processed data' do
      expect(subject.data(data)).to eq(processed_data)
    end
  end
end

class MockReadingLevelDataProcessor

  def self.processed_data
    {
      composite_reading_level: 0, ari_reading_level: 0, coleman_liau_reading_level: 0,
      flesch_kincaid_reading_level: 0, gunning_fog_reading_level: 0, smog_reading_level: 0
    }
  end

  def self.data
   "{\"timestamp\":\"2015-02-20T03:51:02.243663+00:00\",\"data\":{\"composite\":0,\"flesch-kincaid\":0,\"gunning-fog\":0,\"ari\":0,\"smog\":0,\"coleman-liau\":0},\"error\":false}"
  end
end