class Disponibilidade < ActiveRecord::Base
	belongs_to :professor
	belongs_to :horario
	# TODO implementar metodo para promover uma DisciplinaNormal em DisciplinaFixa e vice-versa
	# normalmente utilizado quando a Habilitacao relacionada à disciplina_fixa for excluida.
end
