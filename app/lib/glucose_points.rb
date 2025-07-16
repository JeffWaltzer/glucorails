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

  def empty?
    @points.empty?
  end

  def time_values
    map(&:first)
  end

  def glucose_values
    map(&:second)
  end

  def y_max
    @y_max ||= glucose_values.max
  end

  def sugar_in_range(sugar_value)
    range.include?(sugar_value)
  end

  def y_min
    @y_min ||= glucose_values.min
  end

  def y_max
    @y_max ||= glucose_values.max
  end

  def range
    (y_min..y_max)
  end

end
