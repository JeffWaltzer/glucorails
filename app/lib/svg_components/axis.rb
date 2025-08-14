class SvgComponents::Axis < SvgComponents::Base

  AXIS_COLOR = "#fff"

  def draw_axis_ticks(tik_klass, number_of_tics)
    (0..number_of_tics).each do |index|
      tik_klass.new(index, @svg_points, number_of_tics).draw(@svg_canvas)
    end
  end

end
