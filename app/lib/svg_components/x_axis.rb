# frozen_string_literal: true

module SvgComponents
  class XAxis < Axis

    def number_of_tics
      10
    end

    def tic_mark_class
      XTicMark
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
