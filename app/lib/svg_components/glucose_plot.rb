# frozen_string_literal: true

module SvgComponents
  class GlucosePlot < SvgComponents::Base

    def draw

      @svg_canvas.svg viewBox: @svg_points.viewbox,
                      preserveAspectRatio: :none,
                      x: PLOT_LEFT,
                      y: PLOT_TOP,
                      width: PLOT_WIDTH,
                      height: PLOT_HEIGHT,
                      style: "background: red" do

        SvgComponents::GlucoseHistoryPoints.new(@svg_canvas, @svg_points).draw
        SvgComponents::SugarLine.new(@svg_canvas, @svg_points, GlucosePoints::HEALTHY_SUGAR_HIGH, "high-sugar").draw
        SvgComponents::SugarLine.new(@svg_canvas, @svg_points, GlucosePoints::HEALTHY_SUGAR_LOW, "low-sugar").draw
      end
    end

  end
end
