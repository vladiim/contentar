require 'spec_helper'

RSpec.describe ContentPage do
  let(:data)    { MockContentPage.data }
  let(:subject) { ContentPage.new(data) }

  describe '.new' do
    it 'saves the data' do
      expect(subject.json_data).to eq(data)
    end
  end

  describe '.data' do
    let(:processed_data) { MockContentPage.processed_data }

    it 'returns the processed data' do
      expect(subject.data).to eq(processed_data)
    end
  end
end

class MockContentPage

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