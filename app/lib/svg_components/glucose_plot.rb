# frozen_string_literal: true

module SvgComponents
  class GlucosePlot
    def initialize(svg_canvas, svg_points)
      @svg_canvas = svg_canvas
      @svg_points = svg_points
    end


    def draw
      @svg_canvas.svg viewBox: @svg_points.viewbox,
                      preserveAspectRatio: :none,
                      width: "100%",
                      height: "100%" do

        draw_points_line

        SvgComponents::SugarLine.new(@svg_canvas, @svg_points, GlucosePoints::HEALTHY_SUGAR_HIGH, "high-sugar").draw
        SvgComponents::SugarLine.new(@svg_canvas, @svg_points, GlucosePoints::HEALTHY_SUGAR_LOW, "low-sugar").draw
      end
    end

    def draw_points_line
      @svg_canvas.polyline points: @svg_points.polyline_points,
                           fill: :none,
                           stroke: SvgBuilder::STROKE_COLOR,
                           stroke_width: "20px"
    end
  end
end
