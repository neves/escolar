class Disciplina < ActiveRecord::Base
  belongs_to :material
	has_and_belongs_to_many :professores, :join_table => 'habilitacoes'
	has_many :disponibilidades

	named_scope :fixas, :conditions => {:fixa => true}
	named_scope :normais, :conditions => {:fixa => false}

	def reservas_agrupadas_por_horario
		self.disponibilidades.find(:all, :include => :professor).index_by(&:horario_id)
	end
end
