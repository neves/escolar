class Professor < ActiveRecord::Base
	has_many :disponibilidades
	has_many :horarios, :through => :disponibilidades

	has_many :habilitacoes
	has_many :disciplinas, :through => :habilitacoes

  named_scope :disciplinas, :include => :disciplinas

	named_scope :reservados, 
							:conditions => {'disciplinas.fixa' => true, 'disponibilidades.disciplina_id' => 'habilitacoes.disciplina_id'},
							:include => [:disciplinas, :disponibilidades]
	named_scope :livres,
							:conditions => {'disponibilidades.disciplina_id' => nil},
              :include => :disponibilidades

  before_save :set_default

  def to_s
		nome
	end

  private

  def set_default
    apelido = nome if apelido.nil?
    nome = apelido if nome.nil?
  end
end
