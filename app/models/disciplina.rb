class Disciplina < ActiveRecord::Base
	has_many :habilitacoes
	has_many :professores, :through => :habilitacoes
	has_many :disponibilidades

	named_scope :fixas, :conditions => {:fixa => true}
	named_scope :normais, :conditions => {:fixa => false}

	def reservas_agrupadas_por_horario
		disponibilidades.find(:all, :include => :professor).index_by(&:horario_id)
	end

=begin
  def professores_normais_por_horario
    Horario.find(:all, :include => {:professores => {:habilitacoes => :disciplinas}},
         :conditions => {
            'habilitacoes.disciplina_id' => id,
            'disciplinas.fixa' => false
         }
    ).index_by(&:id)
  end

  def professores_combo_por_horario
    Horario.find(:all, :include => {:professores => :disciplinas},
      :conditions => ['(disciplinas.fixa = false OR disponibilidades.disciplina_id = ?) AND habilitacoes.disciplina_id = ?', id, id]
    ).index_by(&:id)
  end

  def professores_fixos_por_horario
    Horario.find(:all, :include => {:professores => :disciplinas},
         :conditions => {
            'habilitacoes.disciplina_id' => id, # nao traz professor sem habilitação
            'disponibilidades.disciplina_id' => id,
            'disciplinas.fixa' => true
         }
    ).index_by(&:id)
  end
=end

	# FIXME remover scope?
	#named_scope :fixa, :conditions => {:type => 'DisciplinaFixa'}
	#named_scope :normal, :conditions => {:type => 'DisciplinaNormal'}

#	def initialize
#		raise Exception.new("Disciplina é uma classe abstrata. Utilize DisciplinaNormal ou DisciplinaFixa")
#	end
end
