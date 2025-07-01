class GlucoseMeasurement < ApplicationRecord
  def self.points_for(start_time: nil, end_time: nil)
    measurements = start_time.nil? ?
      GlucoseMeasurement.all :
      GlucoseMeasurement.where(measured_at: start_time..)

    measurements.to_a.map do |measurement|
      [measurement.measured_at, measurement.glucose]
    end
  end
end
