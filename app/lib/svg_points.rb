class SvgPoints < GlucosePoints
  def svg_points
    map { |p| point_string(p) }.join(" ")
  end

  def viewbox
    [ x_min, 0, width, height ].join(" ")
  end

  private

  def point_string(point)
    "#{point.first.to_i - start_time},#{y_max - point.second}"
  end
end
