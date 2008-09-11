class Planilha
  def initialize(escola, disciplina, aluno)
  	return if Disciplina.count == 0
  	@escola = escola
    @disciplina = disciplina.to_i == disciplina.to_i.to_s ? Disciplina.find(disciplina) : Disciplina.find_by_apelido(disciplina)
    @aluno = aluno.to_i == aluno.to_i.to_s ? @escola.alunos.find_by_subscricao(aluno) : @escola.alunos.find_by_nome(aluno)
  end
  attr_reader :disciplina
  attr_reader :aluno

  def horas
  	return [] if @disciplina.nil?
    @horas ||= @disciplina.horas.collect(&:hora)
  end

  def dias
    hoje = Date.today
    data_final = hoje + 14.days
    periodo = hoje..data_final
    dias = hoje..data_final
    hoje..data_final
  end

  def horarios
  	return [] if @disciplina.nil?
    @horarios ||= @disciplina.professores_agrupados_por_horario
  end

  def turmas
  	return [] if @disciplina.nil?
    @turmas ||= @disciplina.turmas.no_periodo(dias).group_by(&:quando)
  end

  def aluno_turmas
    return [] unless @aluno
    @aluno.turmas.find(:all, :include => :professor).index_by(&:quando)
  end

  def professores
    turmas = @escola.turmas.find(:all, :conditions => {:data => dias}, :include => [:professor, :disciplina])
    profs = {}
    turmas.each do |t|
      t.disciplina.duracao.times do |d|
        quando = t.quando + d.hours
        profs[quando] ||= []
        profs[quando] << t.professor
      end
    end
    profs
  end
end
