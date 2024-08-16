# frozen_string_literal: true

# TODO
class Robot
  ORIENTATIONS = Set.new(%w[NORTH EAST SOUTH WEST])

  attr_reader :table_width, :table_height, :x, :y, :f

  def initialize(table_width: 5, table_height: 5)
    @table_width = table_width
    @table_height = table_height
  end

  def unplaced?
    x.nil?
  end

  def place(proposed_x, proposed_y, proposed_f)
    puts "proposed_x: #{proposed_x}, proposed_y: #{proposed_y}, proposed_f: #{proposed_f}"

    return false unless proposed_x.between?(0, table_width - 1)
    return false unless proposed_y.between?(0, table_height - 1)
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
