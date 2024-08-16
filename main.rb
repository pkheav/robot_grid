require './lib/grid'

WIDTH = 5
HEIGHT = 5
ORIENTATIONS = Set.new(%w[NORTH EAST SOUTH WEST])

puts 'Enter a PLACE command in the format "PLACE X,Y,F" to place the robot (e.g. PLACE 0,0,NORTH):'

place_cmd = x = y = f = nil
grid = RobotGrid.new

while true
  grid.display

  args = gets.chomp.split(' ')
  cmd = args.first&.upcase
  next unless cmd
  next if grid.robot_unplaced? && cmd != 'PLACE'

  case cmd
  when 'PLACE'
    next unless args.size == 2

    values = args[1].split(',')
    next unless values.size == 3
    next unless (x = Integer(values[0], 10, exception: false))
    next unless (y = Integer(values[1], 10, exception: false))
    next unless (f = values[2].upcase)

    grid.update_xyf(x, y, f)
  when 'MOVE'
    grid.move
  when 'LEFT'
    grid.left
  when 'RIGHT'
    grid.right
  when 'REPORT'
    grid.report
  end
end
