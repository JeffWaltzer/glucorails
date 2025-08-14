class SvgComponents::YTicMark <  SvgComponents::TicMark
  def draw(svg_canvas)
    svg_canvas.line class: "y-tick",
                    x1: 0,
                    x2: 10,
                    y1: 100*@index,
                    y2: 100*@index,
                    stroke: TIC_COLOR
    y_tick_label(svg_canvas)
  end

  private

  def y_tick_label(svg_canvas)
    glucose_value = ((@svg_points.graph_y_max - @svg_points.graph_y_min) * @index/@number_of_tics.to_f +
                      @svg_points.graph_y_min).round

    svg_canvas.text glucose_value,
                    x: 12,
                    y: 100*(@number_of_tics-@index)+5,
                    style: "fill: #{TEXT_COLOR}",
                    class: "y-tick-label"
  end
end
