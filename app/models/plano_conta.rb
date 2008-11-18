class PlanoConta < ActiveRecord::Base
	set_table_name "plano_contas"
	validates_presence_of :nome
	validates_uniqueness_of :nome
	has_many :previsoes
end
