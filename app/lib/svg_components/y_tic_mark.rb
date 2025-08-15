class SvgComponents::YTicMark < SvgComponents::TicMark
  def draw
    @svg_canvas.line class: "y-tick",
                     x1: 40,
                     x2: 50,
                     y1: 95 * (@number_of_tics - @index) ,
                     y2: 95 * (@number_of_tics - @index) ,
                     stroke: TIC_COLOR
    y_tick_label
  end

  private

  def y_tick_label
    y_size = @svg_points.graph_y_max - @svg_points.graph_y_min
    y_position = y_size * @index / @number_of_tics.to_f
    glucose_value = (y_position + @svg_points.graph_y_min).round

    @svg_canvas.text glucose_value,
                     x: 12,
                     y: 95 * (@number_of_tics - @index) + 5 ,
                     style: "fill: #{TEXT_COLOR}",
                     class: "y-tick-label"
  end
end
