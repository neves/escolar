class Disponibilidade < ActiveRecord::Base
	belongs_to :professor
	belongs_to :horario

# def initialize
#    raise Exception.new "Disponibilidade é uma classe abstrata. Utilize DisponibilidadeNormal ou DisponibilidadeFixa"
# end
end
