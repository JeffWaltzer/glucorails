class MakeMeasurementDatesUnique < ActiveRecord::Migration[8.0]
  def change
    add_index :glucose_measurements, :measured_at, unique: true
  end
end
