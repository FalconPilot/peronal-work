
# /------------------------------------------\
# |        Character Sheet Creation          |
# \------------------------------------------/

class CharacterSheet

# ============================================
# |          Class initialization            |
# ============================================

	def initialize(name)
		stats_throw(6, 6, 16, 20)
	end

# ============================================
# |         Stat throwing function           |
# ============================================

	def stats_throw(throws, sides, min, max)
		begin
			total = 0
			result = Array.new(throws, 0)
			throws.times do |i|
				result[i] = rand(1..sides)
				total += result[i]
			end
		end until total >= min && total <= max
		display_result("Basic stats", result)
	end

# ============================================
# |        Stat throw result display         |
# ============================================

	def display_result(name, result)
		puts name + " rolls results"
		result.each_with_index do |value, i|
			puts "•ROLL #{(i + 1)} =	#{value}"
		end
	end

end
