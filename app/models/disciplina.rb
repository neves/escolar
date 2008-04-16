class Disciplina < ActiveRecord::Base
	has_many :habilitacoes
	has_many :professores, :through => :habilitacoes
	named_scope :fixa, :conditions => {:type => 'DisciplinaFixa'}
	named_scope :normal, :conditions => {:type => 'DisciplinaNormal'}

=begin
	def self.fixa(*args)
	  with_scope :find => { :conditions => "type = 'DisciplinaFixa'" } do
      find(*args)
    end
	end
	
	def self.normal(*args)
	  with_scope(:find => { :conditions => "type = 'DisciplinaNormal'" }) do
      find(*args)
    end
	end
=end
end
