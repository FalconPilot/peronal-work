# /------------------------------------------\
# |             Display sheet                |
# \------------------------------------------/

require_relative 'base.rb'

class Display < Base


# ============================================
# |             Initialization               |
# ============================================

    def initialize(sheet)
        super()
        @sheet = sheet
    end

# ============================================
# |           Display all content            |
# ============================================

    def display_all
        header
        @sheet.stats.each_with_index do |stat, i|
            display_stats(stat, i)
            display_choices(@sheet.races[i], "Race")
            display_choices(@sheet.classes[i], "Classe")
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
        gold = " " * (8 - @sheet.misc[0].to_s.length) + @sheet.misc[0].to_s
        bour = " " * (8 - @sheet.misc[1].to_s.length) + @sheet.misc[1].to_s
        dest = " " * (8 - @sheet.misc[2].to_s.length) + @sheet.misc[2].to_s
        puts "#{@yel}Or de départ      #{@std}#{gold}#{@yel}PO#{@std}".center(@s_len + c_len)
        puts "#{@pin}Bonus de bourgeois#{@std}#{gold}#{@yel}PO#{@std}".center(@s_len + c_len)
        puts "#{@cya}Points de destin  #{@std}#{gold}#{@whi}DS#{@std}".center(@s_len + c_len)
    end

# ============================================
# |              Display stats               |
# ============================================

    def display_stats(stats, num = 0)
        display_title("Tirage n°#{num + 1}", @yel)
        c_len = @std.length * 3
        total = 0
        names = ["#{@pin}COU", "#{@cya}INT",
        "#{@gre}ADR", "#{@yel}CHA", "#{@red}FOR"]
        stats.each_with_index do |stat, i|
            total += stat
            puts "#{names[i]}#{@std} =	#{stat}".center(@s_len)
        end
        puts "#{@whi}TOT#{@std} =	#{total}".center(@s_len)
    end

# ============================================
# |            Display choices               |
# ============================================

    def display_choices(choices, name)
        display_title("#{name}s disponibles", @blu)
        counter = 0
        choices.each_with_index do |choice, i|
            counter += 1
            puts "(#{i + 1}) - #{@gre}#{name} disponible :#{@std} #{choice}"
        end
        if counter == 0
            puts "#{@red}Aucune #{name} disponible !#{@std}"
        end
    end

end
