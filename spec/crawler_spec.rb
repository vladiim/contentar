require 'spec_helper'

RSpec.describe Crawler do
  let(:subject) { Crawler.new('http://www.example.com/') }

  describe '.new' do
    it 'has a spider' do
      expect(subject.spider).to be_a SiteSpider
    end
  end
end