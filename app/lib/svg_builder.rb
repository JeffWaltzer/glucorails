class SvgBuilder
  STROKE_COLOR = :white
  TIC_COLOR = :white
  TEXT_COLOR = :white

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

  def draw_empty_graph
    @svg_canvas.text "No data"
  end

  def x_tick_label(index)
    tick_time = (@data.x_max - @data.x_min) * index/10.0 +
                @data.x_min + @data.min_x

    Time.at(tick_time).strftime("%m/%d %l:%M %P")
  end

  def draw_x_axis_tick(index)
      @svg_canvas.line class: "x-tick",
                      x1: 100*(index),
                      x2: 100*(index),
                      y1: 1000,
                      y2: 990,
                      stroke: TIC_COLOR

      @svg_canvas.text x_tick_label(index),
                      x: 100*(index) - 17,
                      y: 985,
                      style: "fill: #{TEXT_COLOR}",
                      class: "x-tick-label"
  end

  def draw_x_axis_ticks
    (0..10).each { |index| draw_x_axis_tick(index) }
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
    glucose_value = (((@data.y_max - @data.y_min) * index/10.0 +
                      @data.y_min) / 100.0).round

    @svg_canvas.text glucose_value,
                     x: 12,
                     y: 100*(10-index)+5,
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
    (0..10).each { |index| draw_y_axis_tick(index) }
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
    end
  end

  def draw_graph
    draw_x_axis
    draw_y_axis
    draw_data
  end
end
