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
                       x1: 50,
                       x2: 50,
                       y1: 0,
                       y2: 950,
                       stroke: AXIS_COLOR
      draw_tics
    end
  end
end
