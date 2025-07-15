# frozen_string_literal: true
class GlucosePoints
  attr_reader :points

  include Enumerable

  def each
    return points.each unless block_given?
    @points.each { |point| yield point }
    self
  end

  def initialize(points)
    @points = points
  end

  def == (other)
    other.is_a?(GlucosePoints) && other.points == self.points
  end

end
