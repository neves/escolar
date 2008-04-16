class Disciplina < ActiveRecord::Base
	has_many :habilitacoes
	has_many :professores, :through => :habilitacoes
end
