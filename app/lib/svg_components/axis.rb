class SvgComponents::Axis < SvgComponents::Base

  AXIS_COLOR = "#fff"

  def draw_axis_ticks(tik_klass)
    (0..number_of_tics).each do |index|
      tik_klass.new(@svg_canvas, @svg_points, index, number_of_tics).draw
    end
  end

end
