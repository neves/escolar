class Disponibilidade < ActiveRecord::Base
	belongs_to :professor
	belongs_to :horario
	belongs_to :disciplina

	named_scope :livres, :conditions => {:disciplina_id => nil}
	named_scope :reservadas, :conditions => "disciplina_id IS NOT NULL"

	def self.agrupadas_por_horario_para_a_disciplina(disciplina)
		free = livres.find(:all, :include => {:professor => :disciplinas}, :conditions => {'habilitacoes.disciplina_id' => disciplina.id})
		lock = reservadas.find(:all, :include => :professor, :conditions => {:disciplina_id => disciplina.id})
		uniao = free + lock
		uniao.group_by(&:horario_id)
	end
end
