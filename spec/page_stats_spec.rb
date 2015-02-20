require 'spec_helper'

RSpec.describe PageStats do
  let(:url)     { URL }
  let(:subject) { PageStats.new(url) }

  describe '.new' do
    it 'stores the url' do
      expect(subject.url).to eq(url)
    end
  end
end