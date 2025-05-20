class GlucoseCsvsController < ApplicationController
  def create
    CsvParser.new(uploaded_csv).build_measurements

    redirect_to graph_path
  end

  private
    def uploaded_csv
      params.require(:csv).read
    end
end
