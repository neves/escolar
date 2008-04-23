class PlanilhaController < ApplicationController
	def index
		@horas = Hora.all.collect(&:id)
		hoje = Date.today
		data_final = hoje + 1.days
		@dias = hoje..data_final
    @disciplina = Disciplina.find_by_apelido('INIT')
    @horarios = Disponibilidade.find(:all, 
                                     :include => {:professor => :habilitacoes}
                                    ).group_by(&:horario_id)
	end
end
