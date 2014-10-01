require 'bundler/setup'
require 'dino'

board = Dino::Board.new(Dino::TxRx::Serial.new)
led = Dino::Components::Led.new(pin: 13, board: board)
photocell = Dino::Components::Sensor.new(pin: 'A0', board: board)

seed = 500
seed_value = 0
seed_state = 0

def initialize
	
end

def SendSeedAlert(seed_value, seed_state)

	if seed_state == 1
		led.send(:on)
		puts "Refill seed, seed_value = #{seed_value}"
	else
		led.send(:off)
		puts "Seed refilled, seed_value = #{seed_value}"
	end

end

# pull photocell value for seeds
# do the block below every 1 second
photocell.when_data_recieved do |data|
	seed_value = data
end

case seed_state
when 0   						#bird feeder seed filled
	if seed_value >= seed
		seed_state = 1
		SendSeedAlert(seed_value, seed_state)
	end
	break
when 1
	if seed_value < seed
		seed_state = 0
		SendSeedAlert(seed_value, seed_state)
	end
	break
end
