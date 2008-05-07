class Disciplina < ActiveRecord::Base
  belongs_to :material
	has_and_belongs_to_many :professores, :join_table => 'habilitacoes'
	has_many :disponibilidades
  has_many :horarios, :through => :disponibilidades
  has_many :turmas

	named_scope :fixas, :conditions => {:fixa => true}
	named_scope :normais, :conditions => {:fixa => false}

  def self.find_by_apelido_or_id(apelido_or_id)
    find(:first, :conditions => ["apelido = :valor OR id = :valor", {:valor => apelido_or_id}])
  end

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

  def professores_agrupados_por_horario
    if self.fixa?
      disp = self.disponibilidades.find(:all, :include => :professor)
    else
      disp = Disponibilidade.livres.find :all,
                                          :include => {:professor => :disciplinas},
                                          :conditions => {'habilitacoes.disciplina_id' => self.id}
    end
    disp.index_and_group_by do |d|
      [d.horario_id, d.professor]
    end
  end

	def reservas_agrupadas_por_horario
		self.disponibilidades.find(:all, :include => :professor).index_by(&:horario_id)
	end

end

