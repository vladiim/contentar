require 'spec_helper'

RSpec.describe DataSaver do
  describe '.csv' do
    let(:result)   { DataSaver.csv(MockDataSaver.filename, MockDataSaver.data) }
    let(:csv_file) { "#{ Dir.pwd }/data/#{ MockDataSaver.filename }.csv" }

    after { FileUtils.rm(csv_file) }

    it 'creates a file' do
      result
      expect(File.file?(csv_file)).to be
    end

    context 'add content' do
      let(:file) { CSV.open(csv_file, 'r') }

      after { file.close }

      it 'adds the header content' do
        result
        headers = file.read[0]
        expect(headers).to eq(['one', 'two'])
      end

      it 'adds the data rows' do
        result
        first_row = file.read[1]
        expect(first_row).to eq(['ONE', 'TWO'])
      end
    end
  end
end

class MockDataSaver
  def self.filename
    'filename'
  end

  def self.data
    [{ one: 'ONE', two: 'TWO' }]
  end
end