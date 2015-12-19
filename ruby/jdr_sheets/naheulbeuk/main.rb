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

    params = ARGV

    @base = Base.new
    @sheet = Sheet.new
    @params = Params.new(params)
    modifs = @params.parse_params
    modifs.each do |option|
        @sheet.send(option)
    end

    @base.header
    @sheet.display_all

end
