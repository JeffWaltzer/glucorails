
class SvgBuilder
  def initialize(data)
    @data = data.dup.map do |datum|
      [datum.first.to_i, datum.second]
    end

    min_x = @data.map(&:first).min

    @data = @data.map do |point|
      [point.first - min_x, point.second]
    end
  end

  def x_min
    0
  end

  def y_min
    @data.map(&:second).min
  end

  def x_max
    @data.map(&:first).map(&:to_i).max
  end

  def y_max
    @data.map(&:second).max
  end

  def width
    x_max - x_min
  end

  def height
    y_max - y_min
  end

  def render_from_csv
    viewbox = [
      x_min,
      y_min,
      width,
      height
    ].join(" ")

    vg = Victor::SVG.new viewBox: viewbox,
                         width: "100%",
                         height: "100%"
    vg.rect x: x_min,
            y: y_min,
            width:,
            height: height

    vg.g do
      vg.polyline points:,
                  fill: :none,
                  stroke: :black
    end
    vg.render
  end

  def point_string(point)
    "#{point.first.to_i},#{point.second}"
  end

  def points
    point_strings = @data.map { |p| point_string(p) }
    point_strings.join(" ")
  end
end
