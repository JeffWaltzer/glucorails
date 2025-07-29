# frozen_string_literal: true
class SvgComponents::XAxis

  def initialize(canvas, glucose_points)
    @canvas = canvas
    @data = glucose_points
  end

  def number_of_x_ticks
    10
  end
  def draw_x_axis_ticks
    draw_axis_ticks(SvgComponents::XTicMark, number_of_x_ticks)
  end

  def draw_x_axis
    @canvas.line id: "x-axis",
                     x1: 0,
                     x2: 1000,
                     y1: 999,
                     y2: 999,
                     stroke: SvgBuilder::STROKE_COLOR
    draw_x_axis_ticks
  end

  def draw_axis_ticks(tik_klass, number_of_tics)
    (0..number_of_x_ticks).each do |index|
      tik_klass.new(index, @data, number_of_tics).draw(@canvas)
    end
  end


end
