class Planilhas::Turmas::AulasController < ApplicationController
  def destroy
    Turma.find(params[:turma_id]).aulas.destroy(Aula.find(params[:id]))
    begin
      Turma.find(params[:turma_id])
      redirect_to :back
    rescue
      redirect_to planilha_path
    end
  end

  def create
    turma = Turma.find(params[:turma_id])
    turma.aulas.create(:aluno_id => params[:aluno_id])
    redirect_to planilha_turma_path(turma)
  end
end
