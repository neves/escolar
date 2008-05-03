class Planilhas::TurmasController < ApplicationController
  def show
    @turma = Turma.find(params[:id], :include => [:alunos, :disciplina, :professor])
    @aluno = Aluno.find(params[:aluno_id]) if params[:aluno_id]
  end

  def destroy
    Turma.destroy(params[:id])
    redirect_to planilha_path
  end
end
