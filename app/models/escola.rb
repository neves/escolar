class Escola < ActiveRecord::Base
  has_many :professores
  has_many :alunos
  has_many :turmas
  has_many :matriculas
end
