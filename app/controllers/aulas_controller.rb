class AulasController < ApplicationController
	def index
		scope = current_escola
		@aluno = current_escola.alunos.find(params[:aluno_id])
		@aulas = @aluno.aulas.all :include => :turma, :order => "turmas.quando"
	end
	
	def sem_nota
		scope = current_escola
		@aluno = current_escola.alunos.find(params[:aluno_id])
		@aulas = @aluno.aulas.sem_nota.all :include => :turma, :order => "turmas.quando"
		render :action => :index
	end
end