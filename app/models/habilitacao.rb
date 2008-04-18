class Habilitacao < ActiveRecord::Base
	belongs_to :professor
	belongs_to :disciplina
	# TODO ao excluir uma habilitacao, deve setar null as disciplina_id das disponibilidades deste professor
end
