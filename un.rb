def SendPerchAlert(perch_value, perch_state)

	if perch_state == 1
		led.send(:on)
		puts "Perch arrival event, perch_value = #{perch_value}"
	else
		led.send(:off)
		puts "Perch departure event, perch_value = #{perch_value}"
	end

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
