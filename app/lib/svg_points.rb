class SvgPoints < Array
  extend Forwardable

  def_delegators :@data, :map, :min, :max, :empty?

  attr_reader :min_x

  def initialize(raw_data)
    @data = raw_data.dup.map do |datum|
      [ datum.first.to_i, datum.second * 100 ]
    end

    @min_x = raw_data.map(&:first).min.to_i

    @data = @data.map do |point|
      [ point.first - @min_x, point.second ]
    end
  end

  def points
    point_strings = @data.map { |p| point_string(p) }
    point_strings.join(" ")
  end

  def point_string(point)
    "#{point.first.to_i},#{point.second}"
  end
end
