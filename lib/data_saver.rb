module DataSaver
  def self.csv(filename, data)
    file    = "#{ Dir.pwd }/data/#{ filename }.csv"
    headers = data[0].keys.map { |k| k.to_s }
    create_csv(file, data, headers)
  end

  private

  def self.create_csv(file, data, headers)
    CSV.open(file, 'w', write_headers: true, headers: headers) do |csv|
      data.each do |d|
        csv << d.values
      end
    end
  end
end