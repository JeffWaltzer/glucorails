# frozen_string_literal: true

module SvgComponents
  class GlucosePlot
    def initialize(svg_canvas, svg_points)
      @svg_canvas = svg_canvas
      @svg_points = svg_points
    end

    def draw_healthy_sugar_lines
      draw_sugar_line(GlucosePoints::HEALTHY_SUGAR_HIGH, "red", "high-sugar")
      draw_sugar_line(GlucosePoints::HEALTHY_SUGAR_LOW, "red", "low-sugar")
    end

    def draw_sugar_line(sugar_value, color, id)
      @svg_canvas.line x1: @svg_points.graph_x_min,
                       y1: @svg_points.invert(sugar_value),
                       x2: @svg_points.graph_x_max,
                       y2: @svg_points.invert(sugar_value),
                       stroke: color,
                       stroke_width: "1px",
                       id: id
    end

    def draw
      @svg_canvas.svg viewBox: @svg_points.viewbox,
                      preserveAspectRatio: :none,
                      width: "100%",
                      height: "100%" do
        draw_points_line
        draw_healthy_sugar_lines
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
