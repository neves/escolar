module PlanilhasHelper
  def celula(dia, hora)
    output = ""
    disp = @horarios[Horario.convert(dia, hora)]
    if disp
      output << disp.collect do |d| 
        link_to d.professor.apelido, 
                "/planilha/agendar?professor_id=" + 
                d.professor.to_param + 
                "&disciplina_id=" + 
                @disciplina.to_param  + 
                "&quando=" + (dia + hora.hours).to_s 
      end * " "
      output << "<hr />"
    end
    turmas = @turmas[dia + hora.hours]
    output << turmas.collect{|d| "#{d.disciplina.apelido}<br />#{d.professor.apelido}" } * "<br />" if turmas
    return output
  end
end
