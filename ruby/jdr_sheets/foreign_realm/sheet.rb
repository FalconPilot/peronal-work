# /------------------------------------------\
# |           Foreign Realm sheet            |
# \------------------------------------------/

class Sheet_Create

# ============================================
# |             Initialization               |
# ============================================

	def initialize
		header
		stat_rolls(16, 20)
		puts "==========================="
	end

# ============================================
# |              Sheet header                |
# ============================================

	def header
		puts "==========================="
		puts "     Création de fiche"
	end

# ============================================
# |               Stat rolls                 |
# ============================================

	def stat_rolls(min, max)
		puts "==========================="
		counter = 0
		stats = Array.new(6, 0)
		begin
			total = 0
			counter += 1
			6.times do |i|
				stats[i] = rand(1..6)
				total += stats[i]
			end
		end until total >= min && total <= max
		stats.each_with_index do |stat, i|
			puts "•Roll #{i + 1} =	#{stat} (#{stat + 8})"
		end
		puts "==========================="
		puts "Total score =	#{total} | (min = #{min}, max = #{max})"
		puts "Fun fact : I had to roll the dices #{counter} time(s) to get a correct score !"
	end

end
