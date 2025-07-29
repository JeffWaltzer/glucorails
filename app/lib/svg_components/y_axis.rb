# frozen_string_literal: true
  class SvgComponents::YAxis


    def initialize(canvas, glucose_points)
      @canvas = canvas
      @data = glucose_points
    end

    def draw_axis_ticks(tik_klass, number_of_tics)
      (0..number_of_tics).each do |index|
        tik_klass.new(index, @data, number_of_tics).draw(@canvas)
      end
    end


    def number_of_y_ticks
      10
    end


    def draw_y_axis_ticks
      draw_axis_ticks(SvgComponents::YTicMark, number_of_y_ticks)
    end

    def draw_y_axis
      @canvas.line id: "y-axis",
                       x1: 1,
                       x2: 1,
                       y1: 0,
                       y2: 1000,
                       stroke: SvgBuilder::STROKE_COLOR
      draw_y_axis_ticks
    end

  end
