class TurmasController < ApplicationController
  def index
    data = Date.today
    @turmas = Turma.find(:all, :conditions => {:data => data}, :include => [:professor, :disciplina, :alunos], :order => 'quando')
  end
end
