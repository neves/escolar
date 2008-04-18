class Disponibilidade < ActiveRecord::Base
	belongs_to :professor
	belongs_to :horario
	belongs_to :disciplina

	named_scope :livres, :conditions => {:disciplina_id => nil}
	named_scope :reservadas, :conditions => "disciplina_id IS NOT NULL"
	
	def self.agrupadas_por_horario
		with_scope :find do
			find(:all).index_by(&:horario_id)
		end
	end

# def initialize
#    raise Exception.new "Disponibilidade é uma classe abstrata. Utilize DisponibilidadeNormal ou DisponibilidadeFixa"
# end
end
