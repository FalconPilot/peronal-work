# /------------------------------------------\
# |             Main Naheulbeuk              |
# \------------------------------------------/

require_relative 'sheet.rb'
require_relative 'base.rb'

begin

# ============================================
# |              Main program                |
# ============================================
	
	@base = Base.new
	@sheet = Sheet_Create.new

	@base.header
	@sheet.display_all

end
