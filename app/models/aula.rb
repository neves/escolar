class Aula < ActiveRecord::Base
  belongs_to :turma
  belongs_to :aluno

  named_scope :sem_nota, :conditions => {:total => nil}

  after_destroy  {|record| record.turma.destroy if record.turma.vazia?}
end
