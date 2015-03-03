module DataSaver
  def self.csv(filename, data)
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
end