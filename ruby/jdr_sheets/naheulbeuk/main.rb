# /------------------------------------------\
# |             Main Naheulbeuk              |
# \------------------------------------------/

require_relative 'sheet.rb'
require_relative 'base.rb'
require_relative 'params.rb'

begin

# ============================================
# |              Main program                |
# ============================================

    args = ARGV

    sheet = Sheet.new
    param = Params.new(args)

    params = param.parse_params
    params.each do |option|
        sheet.send(option)
    end

    sheet.display_all

end
