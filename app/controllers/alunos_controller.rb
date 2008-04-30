class AlunosController < ApplicationController
  def index
    @busca = params[:aluno][:nome_ou_subscricao]
    @alunos = Aluno.find(:all, :conditions =>["nome LIKE ? OR subscricao = ?", "%#{@busca}%", @busca],:limit => 10)
  end
end
