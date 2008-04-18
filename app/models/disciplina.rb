class Disciplina < ActiveRecord::Base
	has_many :habilitacoes
	has_many :professores, :through => :habilitacoes
	has_many :disponibilidades

	named_scope :fixas, :conditions => {:fixa => true}
	named_scope :normais, :conditions => {:fixa => false}

	def reservas_agrupadas_por_horario
		disponibilidades.find(:all, :include => :professor).index_by(&:horario_id)
	end
end
