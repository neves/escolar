class Empresa < ActiveRecord::Base
  has_many :professores
  has_many :alunos
end
