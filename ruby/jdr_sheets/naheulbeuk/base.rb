# /------------------------------------------\
# |             Basic parameters             |
# \------------------------------------------/

class Base

# ============================================
# |             Initialization               |
# ============================================

	def initialize
		create_colors
		define_len
		@version = "V.0.1 BÊTA"
		@author = "FalconPilot"
	end

# ============================================
# |             Program header               |
# ============================================

	def header
		display_title("Création de fiche", @red)
		puts center_text("Sheet Generator #{@cya}#{@version}#{@std}", 2)
		puts center_text("Author : #{@cya}#{@author}#{@std}", 2)
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
# |       Creating length variables          |
# ============================================
	def define_len
		@s_len = 40
		@c_len = @std.length
	end

# ============================================
# |            Separation line               |
# ============================================

	def separation(color, corner = '=')
		line = corner[0]
		(@s_len - 1).times do
			line += '='
		end
		line += corner[0]
		puts "#{color}#{line}#{@std}"
	end

# ============================================
# |              Center text                 |
# ============================================

	def center_text(text, colors = 0)
		spaces = ' '
		len = ((@s_len - text.length + @c_len * colors) / 2) - 2
		if len > 0
			len.times do
				spaces += ' '
			end
		end
		result = "#{spaces}#{text}#{spaces}"
		while result.length < @s_len - 1
			result += ' '
		end
		result
	end

# ============================================
# |              Display title               |
# ============================================

	def display_title(title, color)
		separation(color)
		line = center_text(title)
		puts "#{color}|#{@std}#{line}#{color}|#{@std}"
		separation(color)
	end

end
