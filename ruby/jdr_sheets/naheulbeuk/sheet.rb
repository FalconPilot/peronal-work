# /------------------------------------------\
# |            Naheulbeuk sheet              |
# \------------------------------------------/

require_relative 'base.rb'

class Sheet < Base

# ============================================
# |             Initialization               |
# ============================================
	def initialize
		super
		@stats = Array.new(3)
		@races = Array.new(3)
		@classes = Array.new(3)
		@misc = roll_misc
		3.times do |i|
			@stats[i] = roll_stats
			@races[i] = race_choices(@stats[i])
			@classes[i] = class_choices(@stats[i])
		end
	end

# ============================================
# |          Display all content             |
# ============================================

	def display_all
		@stats.each_with_index do |stat, i|
			display_stats(stat, i)
			display_choices(@races[i], "Race")
			display_choices(@classes[i], "Classe")
		end
		display_misc
		separation(@blu)
	end

# ============================================
# |           Display misc rolls             |
# ============================================

	def display_misc
		display_title("Jets divers", @blu)
		gold = @misc[0]
		bonus = @misc[1]
		destin = @misc[2]
		puts "#{@yel}Pièces d'or		#{@std}#{gold}#{@yel}PO#{@std}"
		puts "#{@cya}Bonus de bourgeois	#{@std}+#{bonus}#{@yel}PO#{@std}"
		puts "#{@pin}Points de destin	#{@std}#{destin}"
	end

# ============================================
# |               Stat rolls                 |
# ============================================

	def roll_stats
		total = 0
		stats = Array.new(5, 0)
		5.times do |index|
			stats[index] = (rand(1..6) + 7)
			total += stats[index]
		end
		stats
	end


# ============================================
# |           Display stat roll              |
# ============================================

	def display_stats(stats, num = 0)
		display_title("Tirage n°#{num + 1}", @yel)
		total = 0
		names = Array["#{@pin}COU", "#{@cya}INT", "#{@gre}ADR", "#{@yel}CHA", "#{@red}FOR"]
		stats.each_with_index do |stat, i|
			total += stat
			puts "#{names[i]}#{@std} =	#{stat}"
		end
		puts "#{@bla}Total : #{@std}#{total} (#{@red}min 40, #{@gre}max 65#{@std})"
	end

# ============================================
# |              Race choices                |
# ============================================
	
	def race_choices(stats)
		humain =		Array[0, 0, 0, 0, 0, "Humain"]
		barbare =		Array[12, 0, 0, 0, 13, "Barbare"]
		nain =			Array[11, 0, 0, 0, 12, "Nain"]
		hautelfe =		Array[0, 11, 12, 12, -12, "Haut-elfe"]
		demielfe =		Array[0, 0, 11, 10, 0, "Demi-elfe"]
		elfesylvain =	Array[0, 0, 10, 12, -11, "Elfe sylvain"]
		elfenoir =		Array[0, 12, 13, 0, -12, "Elfe noir"]
		orque =			Array[0, -8, 0, -10, 12, "Orque"]
		demiorque =		Array[0, -10, -11, 0, 12, "Demi-orque"]
		gobelin =		Array[-10, -10, 0, -8, -9, "Gobelin"]
		ogre =			Array[0, -9, -11, -10, 13, "Ogre"]
		semihomme =		Array[12, 10, 0, 0, -10, "Semi-homme"]
		gnomedunord =	Array[0, 10, 13, 0, -8, "Gnome des forêts du nord"]

		races = Array[humain, barbare, nain, hautelfe, demielfe, elfesylvain, elfenoir,
		orque, demiorque, gobelin, ogre, semihomme, gnomedunord]

		determine_choices(stats, races)
	end

# ============================================
# |              Class choices               |
# ============================================

	def class_choices(stats)
		guerrier_gladiateur =	Array[12, 0, 0, 0, 12, "Guerrier/Gladiateur"]
		ninja_assassin =		Array[0, 0, 13, 0, 0, "Ninja/Assassin"]
		voleur =				Array[0, 0, 12, 0, 0, "Voleur"]
		pretre =				Array[0, 0, 0, 12, 0, "Prêtre"]
		mage_sorcier =			Array[0, 12, 0, 0, 0, "Mage/Sorcier"]
		paladin =				Array[12, 10, 0, 11, 9, "Paladin"]
		ranger =				Array[0, 0, 10, 10, 0, "Ranger"]
		menestrel =				Array[0, 0, 11, 12, 0, "Ménestrel"]
		pirate =				Array[11, 0, 11, 0, 0, "Pirate"]
		marchand =				Array[0, 12, 0, 11, 0, "Marchand"]
		ingenieur =				Array[0, 0, 11, 0, 0, "Ingénieur"]
		bourgeois_noble =		Array[0, 10, 0, 11, 0, "Bourgeois/Noble"]

		classes = Array[guerrier_gladiateur, ninja_assassin, voleur, pretre, mage_sorcier,
		paladin, ranger, menestrel, pirate, marchand, ingenieur, bourgeois_noble]

		determine_choices(stats, classes)
	end

# ============================================
# |           Determine choices              |
# ============================================

	def determine_choices(stats, options)
		final = []
		options.each do |choice|
			choice.each_index do |i|
				if choice[i] < 0
					buffer = stats[i] + choice[i]
					if buffer > 0
						break
					end
				else
					buffer = stats[i] - choice[i]
					if buffer < 0
						break
					end
				end
				if i == 4
					final += [choice[5]]
					break
				end
			end
		end
		final
	end

# ============================================
# |            Display choices               |
# ============================================

	def display_choices(choices, name)
		display_title("#{name}s disponibles", @blu)
		counter = 0
		choices.each_with_index do |choice, i|
			if i > 0
				counter += 1
				puts "(#{i}) - #{@gre}#{name} disponible :#{@std} #{choice}"
			end
		end
		if counter == 0
			puts "#{@red}Aucune #{name} disponible !#{@std}"
		end
	end

# ============================================
# |        Rolling gold and destiny          |
# ============================================

	def roll_misc
		Array[rand(2..12) * 10, rand(2..12) * 10, rand(3)]
	end

end
