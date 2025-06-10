class SvgPoints < Array
  extend Forwardable

  def_delegators :@data, :map, :min, :max, :empty?

  def initialize(raw_data)
    @data = raw_data.dup.map do |datum|
      [ datum.first.to_i, datum.second * 100 ]
    end

    @min_x = raw_data.map(&:first).min.to_i

    @data = @data.map do |point|
      [ point.first - @min_x, point.second ]
    end
  end
end
