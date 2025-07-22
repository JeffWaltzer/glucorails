class SvgBuilder
  # Put these somewhere else.
  HEALTHY_SUGAR_LOW = 70
  HEALTHY_SUGAR_HIGH = 180

  STROKE_COLOR = :white
  TEXT_COLOR = :white
  TIC_COLOR = :white

  def initialize(data)
    @svg_points = SvgPoints.new(data)
    @glucose_points = data
    @svg_canvas = Victor::SVG.new viewBox: [0, 0, 1000, 1000],
                                  preserveAspectRatio: :none,
                                  height: "95%",
                                  width: "100%"
  end

  def render_from_csv
    if @glucose_points.empty?
      draw_empty_graph
    else
      draw_graph
    end

    @svg_canvas.render
  end

  private

  def number_of_x_ticks
    10
  end

  def number_of_y_ticks
    10
  end

  def draw_empty_graph
    @svg_canvas.text "No data"
  end

  def invert(sugar_value)
    @glucose_points.y_max - sugar_value
  end

  def draw_axis_ticks(tik_klass, number_of_tics)
    (0..number_of_x_ticks).each do |index|
      tik_klass.new(index, @svg_points, number_of_tics).draw(@svg_canvas)
    end
  end

  def draw_x_axis_ticks
    draw_axis_ticks(XTicMark, number_of_x_ticks)
  end

  def draw_x_axis
    @svg_canvas.line id: "x-axis",
                     x1: 0,
                     x2: 1000,
                     y1: 999,
                     y2: 999,
                     stroke: STROKE_COLOR
    draw_x_axis_ticks
  end

  def draw_y_axis_ticks
    draw_axis_ticks(YTicMark, number_of_y_ticks)
  end

  def draw_y_axis
    @svg_canvas.line id: "y-axis",
                     x1: 1,
                     x2: 1,
                     y1: 0,
                     y2: 1000,
                     stroke: STROKE_COLOR
    draw_y_axis_ticks
  end

  def draw_points_line
    @svg_canvas.polyline points: @svg_points.svg_points,
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
    if @glucose_points.sugar_in_range(sugar_value)
      @svg_canvas.line x1: @svg_points.x_min,
                       y1: invert(sugar_value),
                       x2: @svg_points.x_max,
                       y2: invert(sugar_value),
                       stroke: color,
                       stroke_width: "1px",
                       id: id
    end
  end

  def draw_healthy_sugar_lines
    draw_sugar_line(HEALTHY_SUGAR_HIGH, "red", "high-sugar")
    draw_sugar_line(HEALTHY_SUGAR_LOW, "red", "low-sugar")
  end

  def draw_graph
    draw_x_axis
    draw_y_axis
    draw_data
  end
end
