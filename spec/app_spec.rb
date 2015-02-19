require 'spec_helper'

RSpec.describe App do
  let(:base_url) { URL }
  let(:subject)  { App.new(base_url) }

  before { stub_url_request }

  describe '.new' do
    it 'has a spider' do
      expect(subject.spider).to be_a Spider
    end

    it 'has a crawler' do
      expect(subject.crawler).to be_a Crawler
    end
  end

  describe '#save_data' do
    let(:file_name) { 'example.com.csv' }

    it 'saves the data' do
      allow(subject.crawler).to receive(:get_data) { 'DATA' }
      expect(DataSaver).to receive(:csv).with(file_name, 'DATA')
      subject.save_data
    end
  end
end