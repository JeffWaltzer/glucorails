# frozen_string_literal: true

module SvgComponents
  class YAxis < Axis

    def number_of_tics
      10
    end

    def tic_mark_class
      YTicMark
    end

    def draw
      @svg_canvas.line id: "y-axis",
                       x1: scale_to_x(0),
                       x2: scale_to_x(0),
                       y1: scale_to_y(0),
                       y2: scale_to_y(10),
                       stroke: AXIS_COLOR
      draw_tics
    end
  end
end
