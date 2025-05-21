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

  def existing_measurement_times
    GlucoseMeasurement.pluck(:measured_at)
  end

  def new_measurements
    parse.map do |measurement|
      GlucoseMeasurement.new(
        measured_at: measurement.first,
        glucose: measurement.second,
      )
    end
  end

  def measurements_to_save
    new_measurements.reject do |measurement|
      existing_measurement_times.include?(measurement.measured_at)
    end
  end

  def save_new_measurements
    measurements_to_save.each(&:save!)
  end
end
