class SvgComponents::TicMark
  TIC_COLOR = :white
  TEXT_COLOR = :white

  def initialize(index, data, number_of_tics)
    @index = index
    @data = data
    @number_of_tics = number_of_tics
  end
end
