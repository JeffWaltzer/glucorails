# frozen_string_literal: true

module SvgComponents
  class SugarLine


    def initialize(svg_canvas, svg_points, glucose_value, id)
      @svg_canvas = svg_canvas
      @svg_points = svg_points
      @glucose_value = glucose_value
      @id = id
    end


    def draw
      @svg_canvas.line x1: @svg_points.graph_x_min,
                       y1: @svg_points.invert(@glucose_value),
                       x2: @svg_points.graph_x_max,
                       y2: @svg_points.invert(@glucose_value),
                       stroke: "red",
                       stroke_width: "1px",
                       id: @id
    end


  end
end
