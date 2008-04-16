class Habilitacao < ActiveRecord::Base
	belongs_to :professor
	belongs_to :disciplina
end
