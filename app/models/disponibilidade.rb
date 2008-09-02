class Disponibilidade < ActiveRecord::Base
	belongs_to :professor
	belongs_to :horario
	belongs_to :disciplina

	named_scope :livres, :conditions => {:disciplina_id => nil}
	named_scope :reservadas, :conditions => "disponibilidades.disciplina_id IS NOT NULL"
  #named_scope :no_dia_da_semana, lambda {|semana| {:conditions => {'horarios.semana' => semana}, :include => :horario}}
  #named_scope :entre_os_horarios, lambda {|range| {:conditions => {'horarios.hora' => range}, :include => :horario}}

#  def self.ocupadas
#   find(:all, :conditions => {:ocupada => true})
#  end

	def self.agrupadas_por_horario_para_a_disciplina(disciplina)
		free = livres.find(:all, :include => {:professor => :disciplinas}, :conditions => {'habilitacoes.disciplina_id' => disciplina.id})
		lock = reservadas.find(:all, :include => :professor, :conditions => {:disciplina_id => disciplina.id})
		uniao = free + lock
		uniao.group_by(&:horario_id)
	end

=begin nao eh executado after_save, quando desmarco a disciplina desta disponibilidade
  #after_save :ocupar_ou_desocupar_horarios_seguintes

  private
  def ocupar_ou_desocupar_horarios_seguintes

    #return if ocupada?
    raise Exception.new(disciplina.nil?.to_s)
    disciplina.nil? ? desocupar_horarios_seguintes : ocupar_horarios_seguintes
  end

  def desocupar_horarios_seguintes
    ocupar_horarios_seguintes false
  end

  def ocupar_horarios_seguintes(ocupar = true)
    hora = horario.hora
    semana = horario.semana
    inicio = hora + 1
    fim = hora + disciplina.duracao
    range = inicio...fim
    #raise Exception.new(range.to_a * ", ")
    futuro = professor.disponibilidades.no_dia_da_semana(semana).entre_os_horarios(range.to_a)
    futuro.each do |f|
      f.ocupada = ocupar
      f.disciplina = disciplina
      f.save
    end
  end
=end

end
