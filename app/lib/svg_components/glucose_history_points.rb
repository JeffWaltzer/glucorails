# frozen_string_literal: true

module SvgComponents

  PLOT_POINT_RADIUS = 5

  class GlucoseHistoryPoints < SvgComponents::Base
    def draw


      #    "#{point.first.to_i - points.start_time},#{graph_y_max - point.second}"
      @svg_points.points.map do |point|
        @svg_canvas.circle cx: SvgComponents::Base::scale_to_x(point.first.to_i - @svg_points.start_time),
                           cy: point.second,
                           stroke: SvgBuilder::STROKE_COLOR,
                           stroke_width: "20px",
                           r: PLOT_POINT_RADIUS
      end


      # @svg_canvas.polyline points: @svg_points.polyline_points,
      #                      fill: :none,
      #                      stroke: SvgBuilder::STROKE_COLOR,
      #                      stroke_width: "20px"
    end

  end
end
