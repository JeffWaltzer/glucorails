class GraphController < ApplicationController
  def show
    @start_time = start_time
    @end_time = end_time

    data = GlucoseMeasurement.points_for(start_time: @start_time, end_time:)

    glucose_points = GlucosePoints.new(data)
    @graph = SvgBuilder.new(glucose_points).render.html_safe
  end

  def params_permit
    params.permit(start_time: {}, end_time: {})
  end

  private

  def start_time
    start_time = params_permit[:start_time]
    if start_time
      DateTime.new(start_time[:year].to_i,
                                start_time[:month].to_i,
                                start_time[:day].to_i,
                                0,
                                0,
                                0)
    else
      GlucoseMeasurement.earliest_date
    end
  end

  def end_time
    end_time = params_permit[:end_time]

    if end_time
      DateTime.new(end_time[:year].to_i,
                   end_time[:month].to_i,
                   end_time[:day].to_i,
                   0,
                   0,
                   0)
    else
      GlucoseMeasurement.latest_date
    end
  end
end
