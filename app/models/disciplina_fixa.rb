class DisciplinaFixa < ActiveRecord::Base
	has_many :reservas, :as => :agendavel
end
