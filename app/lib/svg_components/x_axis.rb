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
                       x1: scale_to_x(0),
                       x2: scale_to_x(10),
                       y1: scale_to_y(10)-1,
                       y2: scale_to_y(10)-1,
                       stroke: AXIS_COLOR
      draw_tics
    end
  end
end
