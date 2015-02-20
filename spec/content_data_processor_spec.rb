require 'spec_helper'

RSpec.describe ContentDataProcessor do
  let(:subject) { ContentDataProcessor.new }

  describe '.data' do
    let(:data)           { MockContentDataProcessor.data }
    let(:processed_data) { MockContentDataProcessor.processed_data }

    it 'returns the processed data' do
      expect(subject.data(data)).to eq(processed_data)
    end
  end
end

class MockContentDataProcessor

  def self.processed_data
    { content: html }
  end

  def self.data
    { data: { content: html } }.to_json
  end

  def self.html
    '<!doctype html><html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\"> </body></html>'
  end
end