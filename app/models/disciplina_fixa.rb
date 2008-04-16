class DisciplinaFixa < Disciplina
	has_many :reservas, :as => :agendavel
end
