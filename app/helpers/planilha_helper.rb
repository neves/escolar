module PlanilhaHelper
  def celula(dia, hora)
    disp = @horarios[Horario.convert(dia, hora)]
    if disp
      disp.collect{|d| d.professor.apelido} * "<br />"
    end
  end
end
