class ProfessoresController < ApplicationController
	before_filter :find_professor

	def habilitacoes
		@disciplinas = Disciplina.all
		@habilitadas = @professor.disciplina_ids
	end

	def habilitar
		@professor.disciplina_ids = (params[:professor][:disciplina_ids] rescue [])
		flash[:notice] = "Habilitações Salvas!"
		redirect_to :back
	end

	def disponibilidades
		@feiras = Feira.all
    @horas = Hora.all
		@horarios_disponiveis = @professor.horario_ids
	end

	def disponibilizar
		@professor.horario_ids = (params[:professor][:horario_ids] rescue [])
    flash[:notice] = "Horários Salvas!"
    redirect_to :back
	end

	private
	def find_professor
		@professor = Professor.find params[:id]
	end
end
