class RemoveGlucoseCsvs < ActiveRecord::Migration[8.0]
  def change
    drop_table :glucose_csvs
  end
end
