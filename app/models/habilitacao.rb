class Habilitacao < ActiveRecord::Base
	belongs_to :professor
	belongs_to :disciplina
	# TODO ao excluir uma habilitacao, deve excluir todas as DisponibilidadesFixas que estiverem relacionadas
end
