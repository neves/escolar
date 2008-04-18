class Horario < ActiveRecord::Base
	has_many :disponibilidades
	has_many :professores, :through => :disponibilidades

	has_many :disponibilidade_fixas,
					 :class_name => 'Disponibilidade',
					 :conditions => {'disponibilidades.type' => 'DisponibilidadeFixa'}
end
