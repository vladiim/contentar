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

    it 'adds the data as content' do
      result
      file = File.open(csv_file).read
      byebug
      true
    end
  end
end

class MockDataSaver
  def self.filename
    'filename'
  end

  def self.data
    { 0 => { one: 'ONE', two: 'TWO' } }
  end
end