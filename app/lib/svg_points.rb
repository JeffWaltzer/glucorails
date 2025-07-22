class SvgPoints < GlucosePoints
  attr_reader :start_time

  def initialize(points)
    super
    @start_time = points.time_values.min
  end

  def svg_points
    @points.map { |p| point_string(p) }.join(" ")
  end

  def viewbox
    [ x_min, 0, width, height ].join(" ")
  end

  private

  def point_string(point)
    "#{point.first.to_i - @start_time.to_i},#{y_max - point.second}"
  end
end
