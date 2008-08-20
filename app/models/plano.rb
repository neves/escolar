class Plano < ActiveRecord::Base
	belongs_to :curso
	validates_presence_of :tabela, :nome, :valor_matricula, :qtde_parcelas, :valor_parcela
	validates_numericality_of :valor_matricula, :qtde_parcelas, :valor_parcela

	def tabela_nome_parcela
		"#{tabela} - #{nome} - #{valor_parcela.para_dinheiro.real_formatado}"
	end
end
