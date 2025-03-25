require 'csv'


class GlucoseCsv < ApplicationRecord
  def glucose_measurements
    rows =  CSV
      .parse(csv
              .split("\n")
              .drop(1)
              .join("\n"), headers: true)

    first = rows.first.to_h
    [
      DateTime.strptime(first['Device Timestamp'] ,'%m-%d-%Y %k:%M %p'),
      first['Historic Glucose mg/dL'].to_i
    ]
  end
end

