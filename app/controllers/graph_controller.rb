class GraphController < ApplicationController
  def show
    start_time = params_permit[:start_time]
    if start_time
      @start_time = DateTime.new(start_time[:year].to_i,
                          start_time[:month].to_i,
                          start_time[:day].to_i,
                          0,
                          0,
                          0)
    else
      @start_time = GlucoseMeasurement.earliest_date
    end

    end_time = params_permit[:end_time]
    if end_time
      @end_time = DateTime.new(end_time[:year].to_i,
                                 end_time[:month].to_i,
                                 end_time[:day].to_i,
                                 0,
                                 0,
                                 0)
    else
      @end_time = GlucoseMeasurement.latest_date
    end


    data = GlucoseMeasurement.points_for(start_time: @start_time, end_time: @end_time)


    @graph = SvgBuilder.new(data).render_from_csv.html_safe
  end

  def params_permit
    params.permit(start_time: {}, end_time: {})
  end
end
