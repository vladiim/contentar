require 'spec_helper'

RSpec.describe PageStats do
  let(:url)     { URL }
  let(:subject) { PageStats.new(url) }

  describe '.new' do
    it 'stores the url' do
      expect(subject.url).to eq(url)
    end
  end

  describe '#data' do
    context 'no errors' do
      before do
        allow(SocialDataGetter).to receive(:new).with(any_args) { MockPageStats::MockDataGetter.new('URL') }
        allow(ReadingLevelDataGetter).to receive(:new).with(any_args) { MockPageStats::MockDataGetter.new('URL') }
        allow(ContentDataGetter).to receive(:new).with(any_args) { MockPageStats::MockDataGetter.new('URL') }
        allow(ArticleDataGetter).to receive(:new).with(any_args) { MockPageStats::MockDataGetter.new('URL') }
      end

      it 'returns the merged data' do
        expect(subject.data).to eq(MockPageStats.merged_data)
      end
    end

    context 'errors' do
      before do
        allow(SocialDataGetter).to receive(:new).with(any_args) { MockPageStats::MockErrorDataGetter.new('URL') }
        allow(ReadingLevelDataGetter).to receive(:new).with(any_args) { MockPageStats::MockErrorDataGetter.new('URL') }
        allow(ContentDataGetter).to receive(:new).with(any_args) { MockPageStats::MockErrorDataGetter.new('URL') }
        allow(ArticleDataGetter).to receive(:new).with(any_args) { MockPageStats::MockErrorDataGetter.new('URL') }
      end

      it 'returns the error data' do
        expect(subject.data).to eq(MockPageStats.error_data)
      end
    end
  end
end

module MockPageStats
  def self.data
    { data: 'DATA', content: 'CONTENT', article: 'ARTICLE' }
  end

  def self.error_data
    { error: 'ERROR', word_count: 0 }
  end

  def self.merged_data
    data.merge(word_count: 7)
  end

  class MockDataGetter
    def initialize(url)
    end
    def data
      MockPageStats.data
    end
  end

  class MockErrorDataGetter
    def initialize(url)
    end
    def data
      MockPageStats.error_data
    end
  end
end