# frozen_string_literal: true

# TODO
class Robot
  DEFAULT_TABLE_WIDTH = 5
  DEFAULT_TABLE_HEIGHT = 5
  ORIENTATIONS = {
    NORTH: 0,
    EAST: 1,
    SOUTH: 2,
    WEST: 3
  }.freeze

  attr_reader :table_width, :table_height, :x, :y, :f

  def initialize(table_width: nil, table_height: nil)
    @table_width = table_width || DEFAULT_TABLE_WIDTH
    @table_height = table_height || DEFAULT_TABLE_HEIGHT
  end

  def unplaced?
    !placed?
  end

  def place(proposed_x, proposed_y, proposed_f)
    return false unless proposed_x.between?(0, table_width - 1)
    return false unless proposed_y.between?(0, table_height - 1)
    return false unless ORIENTATIONS.key?(proposed_f)

    @x = proposed_x
    @y = proposed_y
    @f = proposed_f

    true
  end

  def move
    return false unless placed?

    place(x + diff_x, y + diff_y, f)
  end

  def left
    update_f(-1)
  end

  def right
    update_f(1)
  end

  def report
    puts "#{x},#{y},#{f}"
  end

  private

  def placed?
    x != nil
  end

  def update_f(diff_f)
    return false unless placed?

    current_f_index = ORIENTATIONS[f]
    # % 4 because there are 4 orientations and we want index to always be between 0..3
    new_f_index = ORIENTATIONS.values[(current_f_index + diff_f) % 4]
    @f = ORIENTATIONS.key(new_f_index)

    true
  end

  def diff_x
    case f
    when :EAST
      1
    when :WEST
      -1
    else
      0
    end
  end

  def diff_y
    case f
    when :NORTH
      1
    when :SOUTH
      -1
    else
      0
    end
  end
end
