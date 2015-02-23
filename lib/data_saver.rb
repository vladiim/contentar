module DataSaver
  def self.csv(filename, data)
    file = File.open("#{ Dir.pwd }/data/#{ filename }.csv", 'w')
  end
end