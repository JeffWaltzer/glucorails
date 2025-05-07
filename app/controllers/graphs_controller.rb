class GraphsController < ApplicationController
  def show
    data = GlucoseMeasurement.all.to_a.map do |measurement|
      [ measurement.measured_at, measurement.glucose ]
    end

    render xml: SvgBuilder.new(data).render_from_csv
  end

  def params_permit
    params.permit(:id)
  end
end
