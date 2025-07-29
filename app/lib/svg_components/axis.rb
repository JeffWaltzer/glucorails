class SvgComponents::Axis

  AXIS_COLOR = "#fff"

  def draw_axis_ticks(tik_klass, number_of_tics)
    (0..number_of_tics).each do |index|
      tik_klass.new(index, @data, number_of_tics).draw(@canvas)
    end
  end

  def initialize(canvas, glucose_points)
    @canvas = canvas
    @data = glucose_points
  end
end
