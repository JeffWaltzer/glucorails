class GraphsController < ApplicationController
  def show
    data = GlucoseCsv.find(params_permit[:id])

    render xml: SvgBuilder.new(data.glucose_measurements).render_from_csv
  end

  def params_permit
    params.permit(:id)
  end
end
