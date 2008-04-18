class DisciplinasController < ApplicationController
	before_filter :find_disciplina

	def disponibilidades
		somente_disciplina_fixa!
		@feiras 	= Feira.all
		@horas 		= Hora.all
		@vagas = Disponibilidade.agrupadas_por_horario_para_a_disciplina(@disciplina)
		@reservados = @disciplina.reservas_agrupadas_por_horario
	end

	def disponibilizar
		somente_disciplina_fixa!
		disponibilidade_ids = params[:disciplina][:disponibilidade_ids]
		disponibilidade_ids.reject!{|id| id.empty?}
    @disciplina.update_attributes(:disponibilidade_ids => disponibilidade_ids)
    flash[:notice] = "Horários Salvas!"
    redirect_to :back

	end

	private

	def find_disciplina
		@disciplina = Disciplina.find params[:id]
	end

	def somente_disciplina_fixa!
		raise Exception.new("Apenas disciplinas fixas possuem horario fixo!") unless @disciplina.fixa?
	end
end
