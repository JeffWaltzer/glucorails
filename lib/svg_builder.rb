
class SvgBuilder
  def initialize(data)
    @data = data
  end

  def render_from_csv
    viewbox = [
      @data.map(&:first).map(&:to_i).min,
      @data.map(&:second).min,
      @data.map(&:first).map(&:to_i).max,
      @data.map(&:second).max
    ].join(" ")

    vg = Victor::SVG.new viewBox: viewbox,
                         width: 640,
                         height: 480
    vg.g do
      vg.path d: path_d,
              stroke: "#000000",
              stroke_width: 5
    end
    vg.render
  end

  def point_string(point)
    "#{point.first.to_i},#{point.second}"
  end

  def path_d
    point_strings = @data.map { |p| point_string(p) }
    "m" + point_strings.join("l")
  end
end
