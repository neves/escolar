class Professor < ActiveRecord::Base
	has_many :disponibilidades
	has_many :horarios, :through => :disponibilidades # TODO nao consegui faze-lo criar DisponibilidadeNormal

	has_many :habilitacoes
	has_many :disciplinas, :through => :habilitacoes
=begin
	named_scope :disponibilidades, :include => :disponibilidades do
		def agrupadas_por_horario
			self.index_by(&:horario_id)
		end
	end
=end
	named_scope :reservados, 
							:conditions => {'disciplinas.fixa' => true, 'disponibilidades.disciplina_id' => 'habilitacoes.disciplina_id'},
							:include => [:disciplinas, :disponibilidades]
	named_scope :livres,
							:conditions => {'disponibilidades.disciplina_id' => nil},
              :include => :disponibilidades

	def self.disponibilidades_agrupadas_por_horario

	end

	def to_s
		nome
	end

	# TODO nao consegui fazer o relacionamento abaixo que nao funciona com Disponibilidade Abstrata
	#has_many :disponibilidade_normais, :class_name => 'DisponibilidadeNormal'
	#has_many :horarios_normais, :through => :disponibilidade_normais, :source => :horario

#	named_scope :reservados, :conditions => { => 'DisponibilidadeFixa'}, :include => :disponibilidades
#	named_scope :disponiveis, :conditions => {'disponibilidades.type' => 'DisponibilidadeNormal'}, :include => :disponibilidades
end
