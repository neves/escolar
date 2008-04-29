class Planilhas::Turmas::AlunosController < ApplicationController
  def destroy
    Turma.find(params[:turma_id]).alunos.delete(Aluno.find(params[:id]))
    redirect_to :back
  end
end
