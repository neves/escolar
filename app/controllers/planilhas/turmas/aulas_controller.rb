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
end
