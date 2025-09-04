# frozen_string_literal: true

module SvgComponents
  PLOT_LEFT = 50
  PLOT_TOP = 0
  PLOT_WIDTH = 950
  PLOT_HEIGHT = 950

  class Base

    def initialize(svg_canvas, svg_points)
      @svg_canvas = svg_canvas
      @svg_points = svg_points
    end

    def self.scale_to_x(index)
      95 * index + 50
    end

    def self.scale_to_y(index)
      95 * (index)
    end

    def scale_to_x(index)
      SvgComponents::Base::scale_to_x(index)
    end

    def scale_to_y(index)
      SvgComponents::Base::scale_to_y(index)
    end

  end
end
