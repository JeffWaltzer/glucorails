class SvgComponents::XTicMark < SvgComponents::TicMark
  OFFSET_FOR_X_LABEL = 17
  OFFSET_FOR_DATE_LABEL_Y = 25
  OFFSET_FOR_TIME_LABEL_Y = 45

  TICK_START = 9
  TICK_END = 1

  def draw
    @svg_canvas.line class: "x-tick",
                     x1: SvgComponents::Base::scale_to_x(@index),
                     x2: SvgComponents::Base::scale_to_x(@index),
                     y1: SvgComponents::PLOT_HEIGHT + TICK_START,
                     y2: SvgComponents::PLOT_HEIGHT - TICK_END,
                     stroke: TIC_COLOR

    @svg_canvas.text x_tick_date_label,
                     x: SvgComponents::Base::scale_to_x(@index) - OFFSET_FOR_X_LABEL,
                     y: SvgComponents::PLOT_HEIGHT + OFFSET_FOR_DATE_LABEL_Y,
                     style: "fill: #{TEXT_COLOR}",
                     class: "x-tick-date-label"

    @svg_canvas.text x_tick_time_label,
                     x: SvgComponents::Base::scale_to_x(@index) - OFFSET_FOR_X_LABEL,
                     y: SvgComponents::PLOT_HEIGHT + OFFSET_FOR_TIME_LABEL_Y,
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
