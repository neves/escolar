class Professor < ActiveRecord::Base
	has_many :disponibilidades
	has_many :horarios, :through => :disponibilidades # TODO nao consegui faze-lo criar DisponibilidadeNormal
	has_many :habilitacoes
	has_many :disciplinas, :through => :habilitacoes

	# TODO nao consegui fazer o relacionamento abaixo que nao funciona com Disponibilidade Abstrata
	#has_many :disponibilidade_normais, :class_name => 'DisponibilidadeNormal'
	#has_many :horarios_normais, :through => :disponibilidade_normais, :source => :horario

	named_scope :reservados, :conditions => {'disponibilidades.type' => 'DisponibilidadeFixa'}, :include => :disponibilidades
	named_scope :disponiveis, :conditions => {'disponibilidades.type' => 'DisponibilidadeNormal'}, :include => :disponibilidades
end
