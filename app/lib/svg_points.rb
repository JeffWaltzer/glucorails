class SvgPoints
  def initialize(points)
    @points = points
  end

  def polyline_points
    points.map { |p| point_string(p) }.join(" ")
  end

  def viewbox
    [
      viewbox_left,
      viewbox_top,
      viewbox_width,
      viewbox_height
    ].join(" ")
  end

  def viewbox_left
    points.x_min
  end

  def viewbox_top
    0
  end

  def viewbox_width
    graph_x_max - graph_x_min
  end

  def viewbox_height
    graph_y_max - graph_y_min
  end

  def graph_x_min
    points.x_min
  end

  def graph_x_max
    points.x_max
  end

  def graph_y_min
    [points.y_min, GlucosePoints::HEALTHY_SUGAR_LOW].min
  end

  def graph_y_max
    [points.y_max, GlucosePoints::HEALTHY_SUGAR_HIGH].max
  end

  def invert(sugar_value)
    graph_y_max - sugar_value
  end

  def start_time
    points.start_time
  end

  def empty?
    points.empty?
  end

  private

  attr_reader :points

  def point_string(point)
    "#{point.first.to_i - points.start_time},#{graph_y_max - point.second}"
  end
end
