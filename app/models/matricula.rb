class Matricula < ActiveRecord::Base
	belongs_to :user
	belongs_to :escola
	belongs_to :aluno
	belongs_to :curso
	belongs_to :plano
	validates_uniqueness_of :numero_contrato
	validates_presence_of :data_seg_parcela_matricula, :if => :parcelado?
	validates_presence_of :data_inicio_curso,
						  :plano_id,
						  :curso,
						  :escola,
						  :user,
						  :dia_vcto_parcelas,
						  :data_inicio_parcelas,
						  :valor_pri_parcela_matricula,
						  :numero_contrato,
						  :data_pri_parcela_matricula

	#usar_como_dinheiro :valor_pri_parcela_matricula, :valor_seg_parcela_matricula

	before_create :gerar_financeiro

	def validate
		validates_parcelas
	end

	def parcelado?
		! valor_seg_parcela_matricula.blank?
	end

	def gerar_financeiro(gerar = true)
		return [] unless valid?
		parcelas = []
		p = Previsao.new
		parcelas << p
		p.escola = escola
		p.cliente = aluno
		p.historico = "Matrícula"
		p.vencimento = data_pri_parcela_matricula
		p.plano_conta = PlanoConta.find_or_create_by_nome("Matrícula")
		p.pagar_receber = Previsao.RECEBER
		p.valor = valor_pri_parcela_matricula
		p.valor_pago = 0
    	p.parcela = 1
    	p.qtde_parcelas = 1
    	if parcelado?
    		p.qtde_parcelas = 2
    		p2 = p.clone
    		p2.parcela = 2
    		p2.valor = valor_seg_parcela_matricula
    		p2.vencimento = data_seg_parcela_matricula
    		parcelas << p2
		end

		mensalidade = Previsao.new
		mensalidade.pagar_receber = Previsao.RECEBER
		mensalidade.escola = escola
		mensalidade.cliente = aluno
		mensalidade.historico = "Mensalidade"
		mensalidade.plano_conta = PlanoConta.find_or_create_by_nome("Mensalidade")
		mensalidade.vencimento = data_inicio_parcelas
		mensalidade.valor = plano.valor_parcela
		mensalidade.qtde_parcelas = plano.qtde_parcelas
		logger.info plano.qtde_parcelas
		1.upto(plano.qtde_parcelas) do |numero_parcela|
			mensalidade.parcela = numero_parcela
			parcelas << mensalidade
			mensalidade = mensalidade.clone
			mensalidade.vencimento = data_inicio_parcelas + numero_parcela.months
		end

		parcelas.each &:save! if gerar

		return parcelas
	end

	private

	def validates_parcelas
		return if ! parcelado?
		msg = "A soma das parcelas deve ser igual ao valor integral da matrícula"
		errors.add 'valor_seg_parcela_matricula', msg unless soma_das_parcelas_eh_igual_ao_valor_da_matricula?
	end

	def soma_das_parcelas_eh_igual_ao_valor_da_matricula?
		return false if !valor_pri_parcela_matricula? || !valor_seg_parcela_matricula? || plano.nil?
		return valor_pri_parcela_matricula + valor_seg_parcela_matricula == plano.valor_matricula
	end

end
