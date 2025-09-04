# frozen_string_literal: true

module SvgComponents
  class Base

    def initialize(svg_canvas, svg_points)
      @svg_canvas = svg_canvas
      @svg_points = svg_points
    end

    def self.scale_to_x(value)
      95 * value + 50
    end

  end
end
