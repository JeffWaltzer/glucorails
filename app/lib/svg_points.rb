class SvgPoints
  attr_reader :min_x

  def initialize(raw_data)
    @data = raw_data.dup.map do |datum|
      [ datum.first.to_i, datum.second ]
    end

    @min_x = raw_data.map(&:first).min.to_i

    @data = @data.map do |point|
      [ point.first - @min_x, point.second ]
    end
  end

  def empty?
    @data.empty?
  end

  def points
    @data.map { |p| point_string(p) }.join(" ")
  end

  def x_min
    0
  end

  def y_min
    @y_min ||= @data.map(&:second).min
  end

  def x_max
    @x_max ||= @data.map(&:first).map(&:to_i).max
  end

  def y_max
    @y_max ||= @data.map(&:second).max
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

  def point_string(point)
    "#{point.first.to_i},#{y_max - point.second}"
  end
end
