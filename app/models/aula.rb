class Aula < ActiveRecord::Base
  belongs_to :turma
  belongs_to :aluno
end
