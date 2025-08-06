# frozen_string_literal: true

class GlucosePoints
  attr_reader :points

  include Enumerable

  def initialize(points)
    @points = points
  end

  def each
    return points.each unless block_given?
    points.each { |point| yield point }
    self
  end

  def == (other)
    other.is_a?(GlucosePoints) && other.points == self.points
  end

  def empty?
    points.empty?
  end

  def time_values
    map(&:first)
  end

  def glucose_values
    map(&:second)
  end

  def start_time
    @start_time ||= time_values.min.to_i
  end

  def time_integers
    time_values.map(&:to_i)
  end

  def x_min
    @x_min ||= time_integers.min - start_time
  end

  def x_max
    @x_max ||= time_integers.max - start_time
  end

  def y_min
    @y_min ||= glucose_values.min
  end

  def y_max
    @y_max ||= glucose_values.max
  end
end
