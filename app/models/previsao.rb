class Previsao < ActiveRecord::Base
	RECEBER = "R"
	PAGAR = "P"

	def self.RECEBER
		RECEBER
	end
	
	def self.PAGAR
		PAGAR
	end

	belongs_to :escola
	belongs_to :cliente, :polymorphic => true
	belongs_to :plano_conta

	# @TODO validates_presence_of :all, :except => %w(:sobrenome, :idade)
	validates_presence_of :escola,
												:cliente,
												:plano_conta,
      									:pagar_receber,
      									:valor,
      									:valor_pago,
      									:parcela,
												:qtde_parcelas,
      									:historico,
      									:vencimento

	validate :valor_pago_deve_ser_menor_que_o_valor_total

	validates_numericality_of :valor
	# @TODO :less_than_or_equal_to => :valor
	validates_numericality_of :valor_pago

	validates_numericality_of :parcela, :only_integer => true
	validates_numericality_of :qtde_parcelas, :only_integer => true
	validate :parcela_atual_deve_ser_menor_ou_igual_a_qtde_de_parcelas
	validates_inclusion_of :pagar_receber, :in => %w( P R ) # CONTA_A_PAGAR ou CONTA_A_RECEBER

	# usar_como_dinheiro :valor, :valor_pago

	private
		def valor_pago_deve_ser_menor_que_o_valor_total
			msg = "valor pago #{valor_pago.para_dinheiro.real_formatado} deve ser menor que o valor total #{valor.para_dinheiro.real_formatado}"
			errors.add :valor_pago, msg if valor_pago.para_dinheiro > valor.para_dinheiro
		end

		def parcela_atual_deve_ser_menor_ou_igual_a_qtde_de_parcelas
			msg = "parcela atual #{parcela} deve ser menor ou igual a qtde de parcelas #{qtde_parcelas}"
			errors.add :parcela, msg if parcela > qtde_parcelas
		end
end
