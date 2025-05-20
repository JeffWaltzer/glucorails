class GraphController < ApplicationController
  def show
    data = GlucoseMeasurement.points_for(date: params_permit[:date])

    @graph = SvgBuilder.new(data).render_from_csv.html_safe
  end

  def params_permit
    params.permit(:date)
  end
end
