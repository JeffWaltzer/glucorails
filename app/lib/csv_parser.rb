class CsvParser
  def initialize(csv)
    @csv = csv
  end

  def parse
    rows = CSV.parse(
      @csv.split(/\r*\n/)
        .drop(1)
        .map(&:chomp)
        .join("\n"), headers: true)

    rows
      .select { |row| row["Record Type"]=="0" }
      .map do |row|
        [
          DateTime.strptime(row["Device Timestamp"], "%m-%d-%Y %k:%M %p"),
          row["Historic Glucose mg/dL"].to_i
        ]
      end
  end

  def new_measurements
    parse.map do |measurement|
      GlucoseMeasurement.new(
        measured_at: measurement.first,
        glucose: measurement.second
      )
    end
  end

  def save_new_measurements
    to_save = new_measurements.map do |measurement|
      {
        measured_at: measurement.measured_at,
        glucose: measurement.glucose
      }
    end

    GlucoseMeasurement.insert_all(to_save, unique_by: :measured_at, returning: false)
  end
end
