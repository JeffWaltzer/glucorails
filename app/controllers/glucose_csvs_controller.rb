class GlucoseCsvsController < ApplicationController
  # POST /glucose_csvs or /glucose_csvs.json
  def create
    CsvParser.new(uploaded_csv).build_measurements
  end

  private
    # Only allow a list of trusted parameters through.
    def uploaded_csv
      params.require(:csv).read
    end
end
