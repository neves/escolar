class Matricula < ActiveRecord::Base
	belongs_to :user
	belongs_to :escola
	belongs_to :aluno
	belongs_to :curso
	belongs_to :plano
	validates_uniqueness_of :numero_contrato
	validates_presence_of :data_inicio_curso, 
						  :plano, 
						  :dia_vcto_parcelas, 
						  :data_inicio_parcelas, 
						  :valor_parcelas, 
						  :valor_pri_parcela_matricula,
						  :numero_contrato,
						  :data_pri_parcela_matricula
end
