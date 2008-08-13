class PlanilhasController < ApplicationController
  auto_complete_for :aluno, :nome_ou_subscricao

	def show
		busca_aluno = params[:aluno] && params[:aluno][:nome_ou_subscricao]
		planilha = Planilha.new(params[:apelido] || '1A', busca_aluno)
		@disciplina = planilha.disciplina
		@disciplinas = Disciplina.find(:all, :order => :nome)
		@horas = planilha.horas
		@dias = planilha.dias 
		@horarios = planilha.horarios
		@turmas = planilha.turmas
		@aluno = planilha.aluno
		@aluno_turmas = planilha.aluno_turmas
		@professores_ocupados = planilha.professores
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
