class DisciplinasController < ApplicationController
	before_filter :find_disciplina

	def disponibilidades
		somente_disciplina_fixa!
		@feiras 	= Feira.all
		@horas 		= Hora.all
		@normais 	= @disciplina.professores_normais_por_horario
		@fixos 		= @disciplina.professores_fixos_por_horario
		@combo 		= @disciplina.professores_combo_por_horario
	end

	def disponibilizar
		somente_disciplina_fixa!
	end

	private

	def find_disciplina
		@disciplina = Disciplina.find params[:id]
	end

	def somente_disciplina_fixa!
		raise Exception.new("Apenas disciplinas fixas possuem horario fixo!") unless @disciplina.is_a? DisciplinaFixa
	end
end
