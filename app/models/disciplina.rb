class Disciplina < ActiveRecord::Base
	has_many :habilitacoes
	has_many :professores, :through => :habilitacoes

	# FIXME remover scope?
	#named_scope :fixa, :conditions => {:type => 'DisciplinaFixa'}
	#named_scope :normal, :conditions => {:type => 'DisciplinaNormal'}

#	def initialize
#		raise Exception.new("Disciplina é uma classe abstrata. Utilize DisciplinaNormal ou DisciplinaFixa")
#	end
end
