class SvgComponents::YTicMark < SvgComponents::TicMark

  OFFSET_FOR_TEXT_X = 12
  OFFSET_FOR_TEXT_Y = 5

  TICK_WIDTH = 10

  def draw
    index = @number_of_tics - @index
    @svg_canvas.line class: "y-tick",
                     x1: SvgComponents::PLOT_LEFT - TICK_WIDTH,
                     x2: SvgComponents::PLOT_LEFT,
                     y1: scale_to_y(index),
                     y2: scale_to_y(index),
                     stroke: TIC_COLOR
    y_tick_label
  end

  private


  def y_tick_label
    y_size = @svg_points.graph_y_max - @svg_points.graph_y_min
    y_position = y_size * @index / @number_of_tics.to_f
    glucose_value = (y_position + @svg_points.graph_y_min).round

    @svg_canvas.text glucose_value,
                     x: OFFSET_FOR_TEXT_X,
                     y: scale_to_y(@number_of_tics - @index) + OFFSET_FOR_TEXT_Y,
                     style: "fill: #{TEXT_COLOR}",
                     class: "y-tick-label"
  end
end
