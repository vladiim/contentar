require 'spec_helper'

RSpec.describe Spider do
  let(:url)     { URL }
  let(:subject) { Spider.new(url)}

  describe '.new' do
    it 'sets up the base_path' do
      expect(subject.base_path).to eq(url)
    end
  end

  describe '#get_data' do
    before { stub_url_request }

    context '@data empty' do
      it 'returns the data for the site urls, titles and publish date' do
        expect(subject.get_data).to eq(mock_data)
      end

      it 'ignores js and css files' do
        expect(Spidr).to receive(:site).with(url, ignore_links: [/.js/, /.css/])
        subject.get_data
      end
    end
  end
end