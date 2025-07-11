class SvgBuilder
  # Put these somewhere else.
  HEALTHY_SUGAR_LOW = 70
  HEALTHY_SUGAR_HIGH = 180

  STROKE_COLOR = :white
  TEXT_COLOR = :white
  TIC_COLOR = :white

  def initialize(data)
    @data = SvgPoints.new(data)
    @svg_canvas = Victor::SVG.new viewBox: [ 0, 0, 1000, 1000 ],
                                 preserveAspectRatio: :none,
                                 height: "95%",
                                 width: "100%"
  end

  def render_from_csv
    if @data.empty?
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
    @data.y_max - sugar_value
  end

  def draw_x_axis_ticks
    (0..number_of_x_ticks).each do |index|
      XTicMark.new(index, @data, number_of_x_ticks).draw(@svg_canvas)
    end
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

  def y_tick_label(index)
    glucose_value = ((invert(@data.y_min) * index/number_of_y_ticks.to_f +
                      @data.y_min)).round

    @svg_canvas.text glucose_value,
                     x: 12,
                     y: 100*(number_of_y_ticks-index)+5,
                     style: "fill: #{TEXT_COLOR}",
                     class: "y-tick-label"
  end

  def draw_y_axis_tick(index)
    @svg_canvas.line class: "y-tick",
                     x1: 0,
                     x2: 10,
                     y1: 100*(index),
                     y2: 100*(index),
                     stroke: TIC_COLOR
    y_tick_label(index)
  end

  def draw_y_axis_ticks
    (0..number_of_y_ticks).each { |index| draw_y_axis_tick(index) }
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
    @svg_canvas.polyline points: @data.points,
                         fill: :none,
                         stroke: STROKE_COLOR,
                         stroke_width: "20px"
  end

  def draw_data
    @svg_canvas.svg viewBox: @data.viewbox,
                    preserveAspectRatio: :none,
                    width: "100%",
                    height: "100%" do
      draw_points_line
      draw_healthy_sugar_lines
    end
  end

  def draw_sugar_line(sugar_value, color, id)
    if @data.range.include?(sugar_value)
      @svg_canvas.line x1: @data.x_min,
                       y1: invert(sugar_value),
                       x2: @data.x_max,
                       y2: invert(sugar_value),
                       stroke: color,
                       stroke_width: "2px",
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
