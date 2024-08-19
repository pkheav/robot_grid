# frozen_string_literal: true

require './lib/runner'

puts 'Enter a PLACE command in the format "PLACE X,Y,F" to place the robot (e.g. PLACE 0,0,NORTH):'

Runner.start
