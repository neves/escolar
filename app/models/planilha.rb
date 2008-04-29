class Planilha
  def initialize(disciplina, aluno)
    @disciplina = Disciplina.find_by_apelido_or_id(disciplina)
    @aluno = Aluno.find_by_nome_or_subscricao(aluno)
  end
  attr_reader :disciplina
  attr_reader :aluno

  def horas
    @horas ||= @disciplina.horas.collect(&:hora)
  end

  def dias
    hoje = Date.today.at_beginning_of_week
    data_final = hoje + 5.days
    periodo = hoje..data_final
    dias = hoje..data_final
    hoje..data_final
  end

  def horarios
    @horarios ||= @disciplina.professores_agrupados_por_horario
  end

  def turmas
    @turmas ||= @disciplina.turmas.no_periodo(dias).group_by(&:quando)
  end
end
