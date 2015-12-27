# /------------------------------------------\
# |             Main Naheulbeuk              |
# \------------------------------------------/

require_relative 'params.rb'
require_relative 'display_base.rb'
require_relative 'sheet.rb'
require_relative 'display.rb'

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
