module Utils
	module ArrayMethods
		refine Array do
			def clip
				self[1..-2]
			end
		end
	end
end