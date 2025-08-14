class SvgComponents::TicMark < SvgComponents::Base
  TIC_COLOR = :white
  TEXT_COLOR = :white

  def initialize(svg_canvas, svg_points, index, number_of_tics)
    super(svg_canvas,svg_points)
    @index = index
    @number_of_tics = number_of_tics
  end
end
