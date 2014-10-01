require 'bundler/setup'
require 'dino'

#capacitive sensing library in ruby

board = Dino::Board.new(Dino::TxRx::Serial.new)
led = Dino::Components::Led.new(pin: 13, board: board)
# foil_sensor

on_perch = 1500
cap_sense = 30
perch_value = 0
perch_state = 0

def initialize
	
end

def SendPerchAlert(perch_value, perch_state)

	if perch_state == 1
		led.send(:on)
		puts "Perch arrival event, perch_value = #{perch_value}"
	else
		led.send(:off)
		puts "Perch departure event, perch_value = #{perch_value}"
	end

end

# pull foil perch value
# perch_value = foil_sensor.

case perch_state
when 0
	if perch_value >= on_perch
		perch_state = 1
		SendPerchAlert(perch_value, perch_state)
	end
	break
when 1
	if perch_value < on_perch
		perch_state = 0
		SendPerchAlert(perch_value, perch_state)
	end
	break
end
