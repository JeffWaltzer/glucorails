class GlucoseMeasurement < ApplicationRecord
  def self.points_for(start_time: nil, end_time: nil)
    measurements = GlucoseMeasurement.where(measured_at: start_time..end_time&.end_of_day)
    measurements.pluck(:measured_at, :glucose)
  end
end
