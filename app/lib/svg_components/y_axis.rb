# frozen_string_literal: true

module SvgComponents
  class YAxis < Axis

    def number_of_ticks
      10
    end

    def draw_tics
      draw_axis_ticks(YTicMark, number_of_ticks)
    end

    def draw
      @svg_canvas.line id: "y-axis",
                       x1: 1,
                       x2: 1,
                       y1: 0,
                       y2: 1000,
                       stroke: AXIS_COLOR
      draw_tics
    end
  end
end
