class GlucoseCsvsController < ApplicationController
  # POST /glucose_csvs or /glucose_csvs.json
  def create
    csv= create_params[:csv].read
    CsvParser.new(csv).build_measurements
  end

  private
    # Only allow a list of trusted parameters through.
    def create_params
      params.require(:glucose_csv).permit(:csv)
    end
end
