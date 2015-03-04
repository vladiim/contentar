module DataSaver
  def self.csv(filename, data)
    create_data_dir
    file    = "#{ Dir.pwd }/data/#{ filename }.csv"
    headers = data[0].keys.map { |k| k.to_s }
    create_csv(file, data, headers)
  end

  private

  def self.create_csv(file, data, headers)
    CSV.open(file, 'w', write_headers: true, headers: headers, encoding: 'UTF-8') do |csv|
      data.each do |d|
        values = d.values.map { |value| value.to_s.force_encoding('UTF-8') }
        csv << values
      end
    end
  end

  def self.create_data_dir
    Dir.mkdir('data') unless File.directory?('data')
  end
end