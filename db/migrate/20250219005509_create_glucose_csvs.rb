class CreateGlucoseCsvs < ActiveRecord::Migration[8.0]
  def change
    create_table :glucose_csvs do |t|
      t.text :csv

      t.timestamps
    end
  end
end
