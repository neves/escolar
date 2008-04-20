class PlanilhaController < ApplicationController
	def index
		@horas = Hora.all.collect(&:id)
		hoje = Date.today
		data_final = hoje + 15.days
		@dias = hoje..data_final
#		(hoje..data_final).step(1.day) do |d|
#			def d.to_s
#				"#{day}/#{wday}"
#			end
#		 	@dias << d
#		end
	end
end
