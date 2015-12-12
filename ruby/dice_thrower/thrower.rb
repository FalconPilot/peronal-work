# =======================================
# |            Dice thrower             |
# =======================================

begin
	def prompt(*args)
		print(*args)
		value = gets.to_i
		if value <= 0
			puts "Invalid input ! (must be strictly positive number)"
			exit
		end
		return value
	end

	puts "======================="
	puts "| Random dice-thrower |"
	puts "======================="

	throws = prompt("Enter dice count : ")
	sides = prompt("Enter dice sides : ")
	deriv = prompt("Enter dice range : ")

	dice = Array.new(throws, 0)
	tmin = (throws * sides) / 2 - deriv
	tmax = (throws * sides) / 2 + deriv

	puts "[Total should be between " + tmin.to_s + " and " + tmax.to_s + "]"
	begin 
		total = 0
		throws.times do |index|
			dice[index] = rand(1..sides)
			total += dice[index]
		end 
	end until total >= tmin && total <= tmax
	puts "=================="
	dice.each_with_index do |value, index|
		puts "•ROLL " + (index + 1).to_s + " =	" + value.to_s
	end
	puts "=================="
	puts "Total value =	" + total.to_s
	puts "=================="
end
