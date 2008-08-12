class AlunosController < ApplicationController
	def index
		@busca = params[:aluno][:nome_ou_subscricao]
	    begin
			Integer(@busca)
			@alunos = [Aluno.find_by_subscricao(@busca)]
		rescue
			@alunos = Aluno.all(:conditions => ["nome LIKE ? ", "%#{@busca}%"], :limit => 10)
		end
	end
end
