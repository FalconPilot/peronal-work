# /------------------------------------------\
# |            Naheulbeuk params             |
# \------------------------------------------/

class Params

# ============================================
# |             Initialization               |
# ============================================

    def initialize(params)
        @params = params
    end

# ============================================
# |            Parse parameters              |
# ============================================

    def parse_params
        modif = []
        @params.each do |param|
            case param
                when "-nc" then modif += ["remove_colors"]
            end
        end
        modif
    end

end

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

# /------------------------------------------\
# |             Basic parameters             |
# \------------------------------------------/

class DisplayBase

# ============================================
# |             Initialization               |
# ============================================

    def initialize
        create_colors
        @s_len = 40
        @version = "V.0.2 BÊTA"
        @author = "FalconPilot"
    end

# ============================================
# |             Program header               |
# ============================================

    def header
        display_title("Création de fiche", @red)
        puts "Sheet Generator #{@cya}#{@version}#{@std}".center(@s_len - 1)
        puts "Author : #{@cya}#{@author}#{@std}".center(@s_len - 1)
    end

# ============================================
# |              Remove colors               |
# ============================================

    def remove_colors
        @bla = ""
        @red = ""
        @gre = ""
        @yel = ""
        @blu = ""
        @pin = ""
        @cya = ""
        @whi = ""
        @std = ""
    end

# ============================================
# |            Creating colors               |
# ============================================

    def create_colors
        @bla = "\x1b[30m"
        @red = "\x1b[31m"
        @gre = "\x1b[32m"
        @yel = "\x1b[33m"
        @blu = "\x1b[34m"
        @pin = "\x1b[35m"
        @cya = "\x1b[36m"
        @whi = "\x1b[37m"
        @std = "\x1b[39m"
    end

# ============================================
# |            Separation line               |
# ============================================

    def separation(color, corner = '•')
        line = corner[0] + ('=' * (@s_len - 1)) + corner[0]
        puts "#{color}#{line}#{@std}"
    end

# ============================================
# |              Display title               |
# ============================================

    def display_title(title, color)
        separation(color)
        puts "#{color}|#{@std}#{title.center(@s_len - 1)}#{color}|#{@std}"
        separation(color)
    end

end

# /------------------------------------------\
# |             Display sheet                |
# \------------------------------------------/

class Display < DisplayBase


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

# /------------------------------------------\
# |             Main Naheulbeuk              |
# \------------------------------------------/

begin

# ============================================
# |              Main program                |
# ============================================

    args = ARGV

    sheet = Sheet.new
    param = Params.new(args)
    display = Display.new(sheet)

    params = param.parse_params
    params.each do |option|
        display.send(option)
    end
    display.display_all

end


