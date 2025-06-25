class GlucoseMeasurement < ApplicationRecord
  def self.points_for(date: nil)
    measurements = date.nil? ?
      GlucoseMeasurement.all :
      GlucoseMeasurement.where(measured_at: date.all_day)

    measurements.to_a.map do |measurement|
      [measurement.measured_at, measurement.glucose]
    end
  end
end
