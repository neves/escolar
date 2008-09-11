class Escola < ActiveRecord::Base
  has_many :professores
  has_many :alunos
  has_many :turmas
  has_many :matriculas
  has_many :aulas, :through => :turmas
  usar_como_dinheiro :preco_kit
end
