class PlanilhasController < ApplicationController
	def show
    planilha = Planilha.new(params[:apelido] || '1A', 1)
    @disciplina = planilha.disciplina
    @disciplinas = Disciplina.find(:all, :order => :nome)
		@horas = planilha.horas
		@dias = planilha.dias 
    @horarios = planilha.horarios
    @turmas = planilha.turmas
    @aluno = planilha.aluno
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
