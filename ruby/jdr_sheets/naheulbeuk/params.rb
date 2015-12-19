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
				when "-nc"
					modif += ["remove_colors"]
			end
		end
		modif
	end

end
