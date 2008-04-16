class Disponibilidade < ActiveRecord::Base
	belongs_to :horario
	belongs_to :professor
	#belongs_to :agendavel, :polymorphic => true
end
