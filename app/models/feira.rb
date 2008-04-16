class Feira < ActiveRecord::Base
	def to_s
		feira
	end

	def *(value)
		id * value
	end
end
