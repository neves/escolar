class Professor < ActiveRecord::Base
	has_many :disponibilidades
	has_many :horarios, :through => :disponibilidades

	has_many :habilitacoes
	has_many :disciplinas, :through => :habilitacoes

	named_scope :reservados, 
							:conditions => {'disciplinas.fixa' => true, 'disponibilidades.disciplina_id' => 'habilitacoes.disciplina_id'},
							:include => [:disciplinas, :disponibilidades]
	named_scope :livres,
							:conditions => {'disponibilidades.disciplina_id' => nil},
              :include => :disponibilidades

	def to_s
		nome
	end
end
