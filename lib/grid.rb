# frozen_string_literal: true

class RobotGrid
  ORIENTATIONS = Set.new(%w[NORTH EAST SOUTH WEST])

  attr_reader :width, :height, :x, :y, :f

  def initialize(width: 5, height: 5)
    @width = width
    @height = height
  end

  def robot_unplaced?
    x.nil?
  end

  def update_xyf(proposed_x, proposed_y, proposed_f)
    puts "proposed_x: #{proposed_x}, proposed_y: #{proposed_y}, proposed_f: #{proposed_f}"

    return false unless proposed_x.between?(0, width - 1)
    return false unless proposed_y.between?(0, height - 1)
    return false unless ORIENTATIONS.include?(proposed_f)

    @x = proposed_x
    @y = proposed_y
    @f = proposed_f

    true
  end

  def display
    puts "\nx: #{x}, y: #{y}, f: #{f}\n"
  end

  def move; end

  def left; end

  def right; end
end
