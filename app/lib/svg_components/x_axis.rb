# frozen_string_literal: true

module SvgComponents
  class XAxis < Axis

    def number_of_tics
      10
    end

    def draw_tics
      draw_axis_ticks(XTicMark)
    end

    def draw
      @svg_canvas.line id: "x-axis",
                       x1: 0,
                       x2: 1000,
                       y1: 999,
                       y2: 999,
                       stroke: AXIS_COLOR
      draw_tics
    end
  end
end
