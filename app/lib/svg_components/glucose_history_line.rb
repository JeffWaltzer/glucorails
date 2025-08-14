# frozen_string_literal: true

module SvgComponents
  class GlucoseHistoryLine < SvgComponents::Base
    def draw
      @svg_canvas.polyline points: @svg_points.polyline_points,
                           fill: :none,
                           stroke: SvgBuilder::STROKE_COLOR,
                           stroke_width: "20px"
    end

  end
end
