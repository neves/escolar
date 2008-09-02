class PlanoConta < ActiveRecord::Base
	validates_presence_of :nome
	validates_uniqueness_of :nome
	has_many :previsoes
end
