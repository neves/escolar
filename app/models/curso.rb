class Curso < ActiveRecord::Base
	has_many :planos
	validates_presence_of :nome
	
	def to_s
		nome
	end
end
