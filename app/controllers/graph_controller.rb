class GraphController < ApplicationController
  def show
    if params[:date]
      time = DateTime.new(params[:date][:year].to_i,
                          params[:date][:month].to_i,
                          params[:date][:day].to_i,
                          0,
                          0,
                          0)
    else
      time = nil
    end
    data = GlucoseMeasurement.points_for(date: time)

    @graph = SvgBuilder.new(data).render_from_csv.html_safe
  end

  def params_permit
    params.permit(:date)
  end
end
