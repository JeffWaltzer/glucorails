# frozen_string_literal: true
class GlucosePoints
  attr_reader :points

  include Enumerable

  def each
    return points.each unless block_given?
    @points.each {|point| yield point}
    self
  end

  def initialize(points)
    @points = points
  end

  def == (other)
    other&.points == self.points
  end

  # def first
  #   @points.first
  # end

end
