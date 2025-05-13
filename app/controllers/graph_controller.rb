class GraphController < ApplicationController
  def show
    data = GlucoseMeasurement.points_for

    render xml: SvgBuilder.new(data).render_from_csv
  end

  def params_permit
    params.permit(:id)
  end

end
