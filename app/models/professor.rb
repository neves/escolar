class Professor < ActiveRecord::Base
	has_many :disponibilidades, :as => :agendavel
end
