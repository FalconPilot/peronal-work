# /------------------------------------------\
# |            Naheulbeuk sheet              |
# \------------------------------------------/

class Sheet

attr_reader :stats, :races, :classes, :misc

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
# |              Race choices                |
# ============================================
    
    def race_choices(stats)
        ra0 =       [0, 0, 0, 0, 0, "Humain"]
        ra1 =       [12, 0, 0, 0, 13, "Barbare"]
        ra2 =       [11, 0, 0, 0, 12, "Nain"]
        ra3 =       [0, 11, 12, 12, -12, "Haut-elfe"]
        ra4 =       [0, 0, 11, 10, 0, "Demi-elfe"]
        ra5 =       [0, 0, 10, 12, -11, "Elfe sylvain"]
        ra6 =       [0, 12, 13, 0, -12, "Elfe noir"]
        ra7 =       [0, -8, 0, -10, 12, "Orque"]
        ra8 =       [0, -10, -11, 0, 12, "Demi-orque"]
        ra9 =       [-10, -10, 0, -8, -9, "Gobelin"]
        ra10 =      [0, -9, -11, -10, 13, "Ogre"]
        ra11 =      [12, 10, 0, 0, -10, "Semi-homme"]
        ra12 =      [0, 10, 13, 0, -8, "Gnome des forêts du nord"]

        races = []
        i = 0
        while binding.eval("defined?(ra#{i})")
            races += [binding.eval("ra#{i}")]
            i += 1
        end
        determine_choices(stats, races)
    end

# ============================================
# |              Class choices               |
# ============================================

    def class_choices(stats)
        cl0 =       [12, 0, 0, 0, 12, "Guerrier/Gladiateur"]
        cl1 =       [0, 0, 13, 0, 0, "Ninja/Assassin"]
        cl2 =       [0, 0, 12, 0, 0, "Voleur"]
        cl3 =       [0, 0, 0, 12, 0, "Prêtre"]
        cl4 =       [0, 12, 0, 0, 0, "Mage/Sorcier"]
        cl5 =       [12, 10, 0, 11, 9, "Paladin"]
        cl6 =       [0, 0, 10, 10, 0, "Ranger"]
        cl7 =       [0, 0, 11, 12, 0, "Ménestrel"]
        cl8 =       [11, 0, 11, 0, 0, "Pirate"]
        cl9 =       [0, 12, 0, 11, 0, "Marchand"]
        cl10 =      [0, 0, 11, 0, 0, "Ingénieur"]
        cl11 =      [0, 10, 0, 11, 0, "Bourgeois/Noble"]

        classes = []
        i = 0
        while binding.eval("defined?(cl#{i})")
            classes += [binding.eval("cl#{i}")]
            i += 1
        end
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
                    break if (stats[i] + choice[i]) > 0
                else
                    break if (stats[i] - choice[i]) < 0
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
# |        Rolling gold and destiny          |
# ============================================

    def roll_misc
        [rand(2..12) * 10, rand(2..12) * 10, rand(3)]
    end

end
