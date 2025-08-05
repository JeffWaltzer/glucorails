class SvgBuilder
  # Put these somewhere else.
  HEALTHY_SUGAR_LOW = 70
  HEALTHY_SUGAR_HIGH = 180

  STROKE_COLOR = "white"
  TEXT_COLOR = "white"
  TIC_COLOR = "white"

  def initialize(data)
    @glucose_points = GlucosePoints.new(data)
    @svg_points = SvgComponents::Points.new(@glucose_points)
    @svg_canvas = Victor::SVG.new viewBox: [0, 0, 1000, 1000],
                                 preserveAspectRatio: :none,
                                 height: "95%",
                                 width: "100%"
  end

  def render
    if @glucose_points.empty?
      draw_empty_graph
    else
      draw_graph
    end

    @svg_canvas.render
  end

  private

  def draw_empty_graph
    @svg_canvas.text(
      "No data",
      fill: SvgBuilder::STROKE_COLOR,
      x: 500,
      y: 500
    )
  end

  def draw_points_line
    @svg_canvas.polyline points: @svg_points.polyline_points,
                         fill: :none,
                         stroke: STROKE_COLOR,
                         stroke_width: "20px"
  end

  def draw_data
    @svg_canvas.svg viewBox: @svg_points.viewbox,
                    preserveAspectRatio: :none,
                    width: "100%",
                    height: "100%" do
      draw_points_line
      draw_healthy_sugar_lines
    end
  end

  def draw_sugar_line(sugar_value, color, id)
    @svg_canvas.line x1: @svg_points.graph_x_min,
                     y1: @svg_points.invert(sugar_value),
                     x2: @svg_points.graph_x_max,
                     y2: @svg_points.invert(sugar_value),
                     stroke: color,
                     stroke_width: "1px",
                     id: id
  end

  def draw_healthy_sugar_lines
    draw_sugar_line(HEALTHY_SUGAR_HIGH, "red", "high-sugar")
    draw_sugar_line(HEALTHY_SUGAR_LOW, "red", "low-sugar")
  end

  def draw_graph
    SvgComponents::XAxis.new(@svg_canvas, @glucose_points).draw
    SvgComponents::YAxis.new(@svg_canvas, @svg_points).draw
    draw_data
  end
end
