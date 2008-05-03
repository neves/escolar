class Aula < ActiveRecord::Base
  belongs_to :turma
  belongs_to :aluno

  after_destroy  {|record| record.turma.destroy if record.turma.vazia?}
end
