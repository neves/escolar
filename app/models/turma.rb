class Turma < ActiveRecord::Base
  belongs_to :professor
  belongs_to :disciplina
  has_many :aulas
  has_many :alunos, :through => :aulas

  named_scope :turmas_no_periodo, lambda {|periodo| {:conditions => {:data => periodo}} }

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
