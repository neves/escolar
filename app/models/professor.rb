class Professor < ActiveRecord::Base
	has_many :disponibilidades
	has_many :horarios, :through => :disponibilidades
	has_many :habilitacoes
	has_many :disciplinas, :through => :habilitacoes
	# TODO implementar utilizando named_scope, disponibilidades.normais e disponibilidades.fixas
end
