class PlanilhasController < ApplicationController
	def show
    @disciplina = Disciplina.find_by_apelido(params[:apelido] || '1A')
    @disciplinas = Disciplina.find(:all, :order => :nome)
		@horas = @disciplina.horas.collect(&:hora)
		hoje = Date.today.at_beginning_of_week
		data_final = hoje + 5.days
    periodo = hoje..data_final
		@dias = hoje..data_final
    @horarios = @disciplina.disponibilidade_dos_professores_agrupadas_por_horario
    @turmas = Turma.turmas_no_periodo(periodo).group_by(&:quando)
	end

  def agendar
    quando = params['quando']
    aluno = Aluno.find(params['aluno_id'] || 1)
    turma = Turma.new
    turma.alunos << aluno
    turma.professor = Professor.find(params['professor_id'])
    turma.disciplina = Disciplina.find(params['disciplina_id'])
    turma.quando = quando
    turma.save
    redirect_to :back
  end
end
