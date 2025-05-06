class CreateGlucoseMeasurements < ActiveRecord::Migration[8.0]
  def change
    create_table :glucose_measurements do |t|
      t.datetime :measured_at, null: false
      t.integer :glucose, null: false

      t.timestamps
    end
  end
end
