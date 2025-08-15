# frozen_string_literal: true

module SvgComponents
  class GlucosePlot < SvgComponents::Base
    def draw

      @svg_canvas.svg viewBox: @svg_points.viewbox,
                      preserveAspectRatio: :none,
                      x: "50",
                      y: "0",
                      width: "950",
                      height: "950" do

        SvgComponents::GlucoseHistoryLine.new(@svg_canvas, @svg_points).draw
        SvgComponents::SugarLine.new(@svg_canvas, @svg_points, GlucosePoints::HEALTHY_SUGAR_HIGH, "high-sugar").draw
        SvgComponents::SugarLine.new(@svg_canvas, @svg_points, GlucosePoints::HEALTHY_SUGAR_LOW, "low-sugar").draw
      end
    end

  end
end
