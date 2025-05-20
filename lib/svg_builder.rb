
class SvgBuilder
  def initialize(data)
    @data = data.dup.map do |datum|
      [datum.first.to_i, datum.second * 100]
    end

    min_x = @data.map(&:first).min

    @data = @data.map do |point|
      [point.first - min_x, point.second]
    end
  end

  def render_from_csv
    return "" if @data.empty?

    viewbox = [
      x_min,
      y_min,
      width,
      height
    ].join(" ")

    vg = Victor::SVG.new viewBox: [0, 0, 1000, 1000],
                         width: "100%",
                         height: "100%"
    vg.rect x: 0,
            y: 0,
            width: 1000,
            height: 1000,
            fill: "PaleGreen"

    vg.svg viewBox: viewbox do
      vg.polyline points:,
                  fill: :none,
                  stroke: :black,
                  stroke_width: "1em"
    end
    vg.render
  end

  def points
    point_strings = @data.map { |p| point_string(p) }
    point_strings.join(" ")
  end

  private

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

  def point_string(point)
    "#{point.first.to_i},#{point.second}"
  end
end
