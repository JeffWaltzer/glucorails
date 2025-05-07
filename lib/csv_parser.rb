class CsvParser
  def initialize(csv)
    @csv = csv
  end

  def parse
    rows = CSV.parse(
      @csv.split("\n")
        .drop(1)
        .join("\n"), headers: true)

    rows.map do |row|
      [
        DateTime.strptime(row["Device Timestamp"], "%m-%d-%Y %k:%M %p"),
        row["Historic Glucose mg/dL"].to_i
      ]
    end
  end

  def build_measurements
    parse.each do |measurement|
      GlucoseMeasurement.create!(
        measured_at: measurement.first,
        glucose: measurement.second,
      )
    end
  end
end
