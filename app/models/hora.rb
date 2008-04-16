class Hora < ActiveRecord::Base
	set_primary_key 'hora'

	def to_s
		hora.to_s
	end

	def +(value)
		hora + value
	end
end
