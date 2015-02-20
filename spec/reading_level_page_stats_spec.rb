require 'spec_helper'

RSpec.describe ReadingLevelPageStats do
  let(:data)    { MockReadingLevelPageStats.data }
  let(:subject) { ReadingLevelPageStats.new(data) }

  describe '.new' do
    it 'saves the data' do
      expect(subject.json_data).to eq(data)
    end
  end

  describe '.data' do
    let(:processed_data) { MockReadingLevelPageStats.processed_data }

    it 'returns the processed data' do
      expect(subject.data).to eq(processed_data)
    end
  end
end

class MockReadingLevelPageStats

  def self.processed_data
    {
      composite: 0, ari: 0, coleman_liau: 0,
      flesch_kincaid: 0, gunning_fog: 0, smog: 0
    }
  end

  def self.data
   "{\"timestamp\":\"2015-02-20T03:51:02.243663+00:00\",\"data\":{\"composite\":0,\"flesch-kincaid\":0,\"gunning-fog\":0,\"ari\":0,\"smog\":0,\"coleman-liau\":0},\"error\":false}"
  end
end