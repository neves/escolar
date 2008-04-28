class Disciplina < ActiveRecord::Base
  belongs_to :material
	has_and_belongs_to_many :professores, :join_table => 'habilitacoes'
	has_many :disponibilidades
  has_many :horarios, :through => :disponibilidades

	named_scope :fixas, :conditions => {:fixa => true}
	named_scope :normais, :conditions => {:fixa => false}

  def to_s
    apelido
  end

  def horas
    Hora.find(:all, :conditions => ["hora <= ?", Hora.maximum(:hora) - self.duracao + 1])
  end

  def disponibilidade_dos_professores_agrupadas_por_horario
    if self.fixa?
      horas = self.disponibilidades.find(:all, :include => :professor)
    else
      horas = Disponibilidade.livres.find :all,
                                              :include => {:professor => :disciplinas},
                                              :conditions => {'habilitacoes.disciplina_id' => self.id}
    end
    horas.group_by(&:horario_id)
  end

	def reservas_agrupadas_por_horario
		self.disponibilidades.find(:all, :include => :professor).index_by(&:horario_id)
	end
end
