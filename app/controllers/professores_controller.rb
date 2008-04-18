class ProfessoresController < ApplicationController
	before_filter :find_professor

	def habilitacoes
		@disciplinas = Disciplina.all
		@habilitadas = @professor.disciplina_ids
	end

	def habilitar
		disciplina_ids = params[:professor] || {:disciplina_ids => []}
		@professor.update_attributes(disciplina_ids)
		flash[:notice] = "Habilitações Salvas!"
		redirect_to :back
	end

	def disponibilidades
		@feiras = Feira.all
    @horas = Hora.all
		@horarios_disponiveis = @professor.horario_ids
	end

	def disponibilizar
		horario_ids = params[:professor] || {:horario_ids => []}
    @professor.update_attributes(horario_ids)
    flash[:notice] = "Horários Salvas!"
    redirect_to :back
	end

	private
	def find_professor
		@professor = Professor.find params[:id]
	end
end
