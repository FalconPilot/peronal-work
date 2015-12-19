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
        header
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
        c_len = @std.length * 4
        display_title("Jets divers", @blu)
        gold = " " * (8 - @misc[0].to_s.length) + @misc[0].to_s
        bour = " " * (8 - @misc[1].to_s.length) + @misc[1].to_s
        dest = " " * (8 - @misc[2].to_s.length) + @misc[2].to_s
        puts "#{@yel}Or de départ      #{@std}#{gold}#{@yel}PO#{@std}".center(@s_len + c_len)
        puts "#{@pin}Bonus de bourgeois#{@std}#{bour}#{@yel}PO#{@std}".center(@s_len + c_len)
        puts "#{@cya}Points de destin  #{@std}#{dest}#{@bla}DS#{@std}".center(@s_len + c_len)
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
        c_len = @std.length * 3
        total = 0
        names = ["#{@pin}COU", "#{@cya}INT",
        "#{@gre}ADR", "#{@yel}CHA", "#{@red}FOR"]
        display_title("Tirage n°#{num + 1}", @yel)
        stats.each_with_index do |stat, i|
            total += stat
            puts "#{names[i]}#{@std} =	#{stat}".center(@s_len)
        end
        puts "#{@bla}TOT#{@std} =	#{total}".center(@s_len)
    end

# ============================================
# |              Race choices                |
# ============================================
    
    def race_choices(stats)
        humain =               [0, 0, 0, 0, 0, "Humain"]
        barbare =              [12, 0, 0, 0, 13, "Barbare"]
        nain =                 [11, 0, 0, 0, 12, "Nain"]
        hautelfe =             [0, 11, 12, 12, -12, "Haut-elfe"]
        demielfe =             [0, 0, 11, 10, 0, "Demi-elfe"]
        elfesylvain =          [0, 0, 10, 12, -11, "Elfe sylvain"]
        elfenoir =             [0, 12, 13, 0, -12, "Elfe noir"]
        orque =                [0, -8, 0, -10, 12, "Orque"]
        demiorque =            [0, -10, -11, 0, 12, "Demi-orque"]
        gobelin =              [-10, -10, 0, -8, -9, "Gobelin"]
        ogre =                 [0, -9, -11, -10, 13, "Ogre"]
        semihomme =            [12, 10, 0, 0, -10, "Semi-homme"]
        gnomedunord =          [0, 10, 13, 0, -8, "Gnome des forêts du nord"]

        races = [humain, barbare, nain, hautelfe,
        demielfe, elfesylvain, elfenoir, orque, demiorque,
        gobelin, ogre, semihomme, gnomedunord]

        determine_choices(stats, races)
    end

# ============================================
# |              Class choices               |
# ============================================

    def class_choices(stats)
        guerrier_gladiateur =  [12, 0, 0, 0, 12, "Guerrier/Gladiateur"]
        ninja_assassin =       [0, 0, 13, 0, 0, "Ninja/Assassin"]
        voleur =               [0, 0, 12, 0, 0, "Voleur"]
        pretre =               [0, 0, 0, 12, 0, "Prêtre"]
        mage_sorcier =         [0, 12, 0, 0, 0, "Mage/Sorcier"]
        paladin =              [12, 10, 0, 11, 9, "Paladin"]
        ranger =               [0, 0, 10, 10, 0, "Ranger"]
        menestrel =            [0, 0, 11, 12, 0, "Ménestrel"]
        pirate =               [11, 0, 11, 0, 0, "Pirate"]
        marchand =             [0, 12, 0, 11, 0, "Marchand"]
        ingenieur =            [0, 0, 11, 0, 0, "Ingénieur"]
        bourgeois_noble =      [0, 10, 0, 11, 0, "Bourgeois/Noble"]

        classes = [guerrier_gladiateur, ninja_assassin,
        voleur, pretre, mage_sorcier,paladin, ranger, menestrel,
        pirate, marchand, ingenieur, bourgeois_noble]

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
# |            Display choices               |
# ============================================

    def display_choices(choices, name)
        display_title("#{name}s disponibles", @blu)
        counter = 0
        choices.each_with_index do |choice, i|
            counter += 1
            puts "(#{i}) - #{@gre}#{name} disponible :#{@std} #{choice}"
        end
        if counter == 0
            puts "#{@red}Aucune #{name} disponible !#{@std}"
        end
    end

# ============================================
# |        Rolling gold and destiny          |
# ============================================

    def roll_misc
        [rand(2..12) * 10, rand(2..12) * 10, rand(3)]
    end

end
