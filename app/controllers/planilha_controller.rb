class PlanilhaController < ApplicationController
	def index
		@horas = Hora.all.collect(&:id)
		hoje = Date.today.at_beginning_of_week
		data_final = hoje + 7.days
		@dias = hoje..data_final
    @disciplina = Disciplina.find_by_apelido(params[:apelido] || '1A')
    filtro = {}
    filtro['habilitacoes.disciplina_id'] = @disciplina.id
    #filtro['disponibilidades.disciplina_id'] = @disciplina.fixa? ? @disciplina.id : nil

    tipo = @disciplina.fixa? ? :reservadas : :livres
    @horarios = Disponibilidade.nao_ocupadas.send(tipo).find(:all,
                                     :include => {:professor => :disciplinas},
                                     :conditions => filtro
                                    ).group_by(&:horario_id)
	end
end
