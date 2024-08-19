# frozen_string_literal: true

require './lib/robot'

puts 'Enter a PLACE command in the format "PLACE X,Y,F" to place the robot (e.g. PLACE 0,0,NORTH):'

robot = Robot.new

loop do
  args = gets.chomp.split(' ')
  cmd = args.first&.upcase&.to_sym
  next unless cmd
  next if robot.unplaced? && cmd != :PLACE

  case cmd
  when :PLACE
    next unless args.size == 2

    values = args[1].split(',')
    next unless values.size == 3
    next unless (x = Integer(values[0], 10, exception: false))
    next unless (y = Integer(values[1], 10, exception: false))
    next unless (f = values[2].upcase.to_sym)

    robot.place(x, y, f)
  when :MOVE
    robot.move
  when :LEFT
    robot.left
  when :RIGHT
    robot.right
  when :REPORT
    robot.report
  when :EXIT
    break
  end
end
