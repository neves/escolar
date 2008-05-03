class TurmasController < ApplicationController
  def index
    data = Date.today
    filtro = {:data => data}
    filtro[:professor_id] = params[:professor_id].to_i if params[:professor_id].to_i > 0
    @current_professor = filtro[:professor_id]
    @turmas = Turma.find(:all, :conditions => filtro, :include => [:professor, :disciplina, :alunos], :order => 'quando')
    @professores = Professor.find(:all, :order => 'nome')
  end
end
