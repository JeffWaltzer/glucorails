class XTicMark < TicMark
  def draw(svg_canvas)
    svg_canvas.line class: "x-tick",
                     x1: 100*@index,
                     x2: 100*@index,
                     y1: 1000,
                     y2: 990,
                     stroke: TIC_COLOR

    svg_canvas.text x_tick_date_label,
                     x: 100*(@index) - 17,
                     y: 965,
                     style: "fill: #{TEXT_COLOR}",
                     class: "x-tick-date-label"

    svg_canvas.text x_tick_time_label,
                    x: 100*@index - 17,
                    y: 985,
                    style: "fill: #{TEXT_COLOR}",
                    class: "x-tick-time-label"
  end

  private

  def tick_time
    Time.at(
      @data.width * @index/@number_of_tics +
      @data.x_min + @data.start_time.to_i
    )
  end

  def x_tick_date_label
    tick_time.strftime("%m/%d")
  end

  def x_tick_time_label
    tick_time.strftime("%l:%M %P")
  end
end
