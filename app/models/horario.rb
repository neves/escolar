class Horario < ActiveRecord::Base
	has_many :disponibilidades
	has_many :professores, :through => :disponibilidades

	# TODO disponibilidades.(fixas|normais)
	# TODO has_many :disciplinas_fixas, :through => :disponibilidades_fixas
	# TODO como fazer a classe ser readonly
	# TODO como definir eu mesmo qual sera o id ?
=begin
	def id
		hora_id.to_i + semana_dia_id.to_i * 100
	end

	def id=(value)
		self.semana_dia_id = value / 100
		self.hora_id = value % 100
		#super.id = value
		write_attribute(self.class.primary_key, value)
	end
=end
end
