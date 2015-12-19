# /------------------------------------------\
# |             Basic parameters             |
# \------------------------------------------/

class Base

# ============================================
# |             Initialization               |
# ============================================

    def initialize
        create_colors
        @s_len = 40
        @version = "V.0.1 BÊTA"
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
