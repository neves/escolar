class Professor < ActiveRecord::Base
	has_many :disponibilidades
	has_many :horarios, :through => :disponibilidades
  has_many :habilitacoes
  has_many :turmas
  # porque eu troquei has_many through por habtm?
	has_and_belongs_to_many :disciplinas, :join_table => 'habilitacoes'

  named_scope :disciplinas, :include => :disciplinas

	named_scope :reservados, 
							:conditions => {'disciplinas.fixa' => true, 'disponibilidades.disciplina_id' => 'habilitacoes.disciplina_id'},
							:include => [:disciplinas, :disponibilidades]
	named_scope :livres,
							:conditions => {'disponibilidades.disciplina_id' => nil},
              :include => :disponibilidades

  def self.disponiveis_para_disciplina(disciplina)
    if disciplina.fixa?
      reservados
      #reservados.find(:all, :conditions => {'disponibilidades.disciplina_id' => disciplina.id})
    else
      #livres.find(:all, :conditions => {'habilitacoes.disciplina_id' => disciplina.id}, :include => :habilitacoes)
    end
  end

  def ocupados_com_turmas_no_periodo(periodo)

  end


  before_save :set_default

  def to_s
		apelido
	end

  private

  def set_default
    apelido = nome if apelido.nil?
    nome = apelido if nome.nil?
  end
end
