class GraphController < ApplicationController
  def show
    start_time = params[:start_time]
    if start_time
      @start_time = DateTime.new(start_time[:year].to_i,
                          start_time[:month].to_i,
                          start_time[:day].to_i,
                          0,
                          0,
                          0)
    else
      @start_time = nil
    end
    data = GlucoseMeasurement.points_for(start_time: @start_time)

    @graph = SvgBuilder.new(data).render_from_csv.html_safe
  end

  def params_permit
    params.permit(:date)
  end
end
