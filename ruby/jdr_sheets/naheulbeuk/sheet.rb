# /------------------------------------------\
# |            Naheulbeuk sheet              |
# \------------------------------------------/

class Sheet_Create

# ============================================
# |             Initialization               |
# ============================================
	def initialize
		@bla = "\x1b[30m"
		@red = "\x1b[31m"
		@gre = "\x1b[32m"
		@yel = "\x1b[33m"
		@blu = "\x1b[34m"
		@pin = "\x1b[35m"
		@cya = "\x1b[36m"
		@whi = "\x1b[37m"
		@std = "\x1b[39m"

		header
		3.times do |i|
			stats = roll_stats(i)
			race_choices(stats)
			class_choices(stats)
		end
		roll_misc
		separation
	end
	def separation
		puts "#{@blu}=========================#{@std}"
	end
# ============================================
# |             Program header               |
# ============================================

	def header
		separation
		puts "    Création de fiche"
	end

# ============================================
# |               Stat rolls                 |
# ============================================

	def roll_stats(num)
		separation
		puts "|      Tirage n°#{num + 1}    	|"
		separation
		total = 0
		stats = Array.new(5, 0)
		names = Array["#{@pin}COU", "#{@cya}INT", "#{@gre}ADR", "#{@yel}CHA", "#{@red}FOR"]
		5.times do |index|
			stats[index] = (rand(1..6) + 7)
			puts "#{names[index]}#{@std} =	#{stats[index]}"
			total += stats[index]
		end
		puts "#{@bla}Total : #{@std}#{total} (#{@red}min 40, #{@gre}max 65#{@std})"
		stats
	end

# ============================================
# |              Race choices                |
# ============================================
	
	def race_choices(stats)
		separation
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

		choices = determine_choices(stats, races, "Race")
	end

# ============================================
# |              Class choices               |
# ============================================

	def class_choices(stats)
		separation
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

		determine_choices(stats, classes, "Classe")
	end

# ============================================
# |           Determine choices              |
# ============================================

	def determine_choices(stats, choices, name)
		counter = 0
		choices.each do |choice|
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
					counter += 1
					puts "#{@gre}#{name} disponible :#{@std} #{choice[5]}"
					break
				end
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
		separation
		puts "#{@yel}Pièces d'or : #{@std}#{rand(2..12) * 10}"
		puts "#{@whi}Points de destin : #{@std}#{rand(3)}"
	end

end
