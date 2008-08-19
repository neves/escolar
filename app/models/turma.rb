class Turma < ActiveRecord::Base
  belongs_to :professor
  belongs_to :disciplina
  belongs_to :escola
  has_many :aulas, :dependent => :delete_all
  has_many :alunos, :through => :aulas

  named_scope :no_periodo, lambda {|periodo| {:conditions => {:data => periodo}} }

  def vazia?
    aulas.empty?
  end

  def lotada?
    return false unless disciplina
    aulas.size >= disciplina.lotacao
  end

  def quando=(datetime)
    datetime = Time.parse(datetime)
    write_attribute(:quando, datetime)
    self.data = datetime.to_date
    self.semana = datetime.wday
    self.hora = datetime.hour
    self.time = datetime.hour
    self.horario_id = Horario.convert(datetime, hora)
  end
end
