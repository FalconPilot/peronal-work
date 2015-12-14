
# /------------------------------------------\
# |       Foreign Lands RPG scripts          |
# \------------------------------------------/

begin
	
# ============================================
# |         Include external files           |
# ============================================

	require_relative 'sheet.rb'

# ============================================
# |             Display header               |
# ============================================

	def header
		puts "=============================="
		puts "|     Foreign Lands RPG      |"
		puts "=============================="
	end

# ============================================
# |             Get user input               |
# ============================================

	def prompt(*args)
		print(*args)
		gets
	end

# ============================================
# |           Print command list             |
# ============================================

	def cmdlist
		puts "Commands :"
		puts "1 - Create a character sheet"
		puts "2 - Quit",""
	end

# ============================================
# |         Create character sheet           |
# ============================================

	def create_sheet
		name = prompt("Enter a character name : ")
		sheet = CharacterSheet.new(name)
	end
	
# ============================================
# |           Main program here              |
# ============================================

	choice = 0
	header
	while true do
		cmdlist
		choice = prompt("Enter a command ID : ").to_i
		case choice
			when 1
				create_sheet
			when 2
				exit
			else
				puts "Invalid command ! (Press enter to continue)"
				gets
		end
	end

end
