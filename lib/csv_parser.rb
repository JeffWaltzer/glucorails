require 'rails_helper'

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

  def build_measurements
    # existing_measurements = GlucoseMeasurement.pluck(:measured_at, :glucose)
    # new_measurements = parse - existing_measurements

    # new_measurements.each do |measurement|
    parse.each do |measurement|
      GlucoseMeasurement.create!(
        measured_at: measurement.first,
        glucose: measurement.second,
      )
    end
  end
end
