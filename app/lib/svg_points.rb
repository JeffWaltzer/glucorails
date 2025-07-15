class SvgPoints
  attr_reader :start_time

  def initialize(data)
    @data=data
    @start_time = data.time_values.min
  end

  def empty?
    @data.empty?
  end

  def points
    @data.map { |p| point_string(p) }.join(" ")
  end

  def x_min
    @x_min ||= time_values.map(&:to_i).min - @start_time.to_i
  end

  def y_min
    @y_min ||= glucose_values.min
  end

  def x_max
    @x_max ||= time_values.map(&:to_i).max - @start_time.to_i
  end

  def y_max
    @y_max ||= glucose_values.max
  end

  def width
    x_max - x_min
  end

  def height
    y_max - y_min
  end

  def viewbox
    [ x_min, 0, width, height ].join(" ")
  end

  def range
    (y_min..y_max)
  end

  private

  def time_values
    @data.time_values
  end

  def glucose_values
    @data.glucose_values
  end

  def point_string(point)
    "#{point.first.to_i - @start_time.to_i},#{y_max - point.second}"
  end
end
