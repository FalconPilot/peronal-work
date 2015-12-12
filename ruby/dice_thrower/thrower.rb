begin
	puts "Generating a new random throw"

	tmin = 16
	tmax = 20
	stats = 6
	dice = Array.new(stats, 0)

	begin 
		total = 0
		stats.times do |index|
			dice[index] = rand(1..6)
			total += dice[index]
		end 
	end until total >= tmin && total <= tmax
	dice.each_with_index do |value, index|
		puts "•ROLL " + (index + 1).to_s + " = " + value.to_s
	end
	puts "Total value = " + total.to_s
end
