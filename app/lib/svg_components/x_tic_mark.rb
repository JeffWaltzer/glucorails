class SvgComponents::XTicMark < SvgComponents::TicMark
  def draw
    @svg_canvas.line class: "x-tick",
                     x1: SvgComponents::Base::scale_to_x(@index),
                     x2: SvgComponents::Base::scale_to_x(@index),
                     y1: 959,
                     y2: 949,
                     stroke: TIC_COLOR

    @svg_canvas.text x_tick_date_label,
                     x: SvgComponents::Base::scale_to_x(@index) - 17,
                     y: 975,
                     style: "fill: #{TEXT_COLOR}",
                     class: "x-tick-date-label"

    @svg_canvas.text x_tick_time_label,
                    x: SvgComponents::Base::scale_to_x(@index)-17,
                    y: 995,
                    style: "fill: #{TEXT_COLOR}",
                    class: "x-tick-time-label"
  end

  private

  def tick_time
    Time.at(
      @svg_points.viewbox_width * @index / @number_of_tics +
      @svg_points.graph_x_min + @svg_points.start_time
    )
  end

  def x_tick_date_label
    tick_time.strftime("%m/%d")
  end

  def x_tick_time_label
    tick_time.strftime("%l:%M %P")
  end
end
