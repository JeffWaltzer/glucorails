class SvgBuilder
  # Put these somewhere else.

  STROKE_COLOR = "white"
  TEXT_COLOR = "white"
  TIC_COLOR = "white"

  def initialize(glucose_points)
    @svg_points = SvgPoints.new(glucose_points)
    @svg_canvas = Victor::SVG.new viewBox: [0, 0, 1000, 1000],
                                 preserveAspectRatio: :none,
                                 height: "95%",
                                 width: "100%"
  end

  def render
    if @svg_points.empty?
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

  def draw_graph
    SvgComponents::XAxis.new(@svg_canvas, @svg_points).draw
    SvgComponents::YAxis.new(@svg_canvas, @svg_points).draw
    SvgComponents::GlucosePlot.new(@svg_canvas, @svg_points).draw
  end
end
