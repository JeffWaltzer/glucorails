class SvgPoints
  def initialize(points)
    @points = points
  end

  def polyline_points
    points.map { |p| point_string(p) }.join(" ")
  end

  def viewbox
    [ points.x_min,
      0,
      points.width,
      points.height
    ].join(" ")
  end

  private

  attr_reader :points

  def point_string(point)
    "#{point.first.to_i - points.start_time},#{points.y_max - point.second}"
  end
end
