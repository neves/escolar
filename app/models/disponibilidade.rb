class Disponibilidade < ActiveRecord::Base
	belongs_to :hora_semana_dia
	belongs_to :agendavel, :polymorphic => true
end
