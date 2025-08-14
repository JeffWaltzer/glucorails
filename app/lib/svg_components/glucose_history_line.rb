# frozen_string_literal: true

module SvgComponents
  class GlucoseHistoryLine
    def initialize(svg_canvas, svg_points)
      @svg_canvas = svg_canvas
      @svg_points = svg_points
    end

    def draw
      @svg_canvas.polyline points: @svg_points.polyline_points,
                           fill: :none,
                           stroke: SvgBuilder::STROKE_COLOR,
                           stroke_width: "20px"
    end

  end
end
