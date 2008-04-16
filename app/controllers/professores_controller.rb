class ProfessoresController < ApplicationController
	before_filter :find_professor

	def habilitacoes
		@disciplinas = Disciplina.all
		@habilitadas = @professor.disciplinas.collect(&:id)
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
		@horarios_disponiveis = @professor.horarios.collect(&:id)
	end

	def disponibilizar
		horarios_ids = params[:professor] || {:horarios_ids => []}
    @professor.update_attributes(horarios_ids)
    flash[:notice] = "Horários Salvas!"
    redirect_to :back
	end

	private
	def find_professor
		@professor = Professor.find params[:id]
	end
end
