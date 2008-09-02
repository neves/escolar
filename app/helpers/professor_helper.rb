module ProfessorHelper
  def abbr_title(disp)
    %(title="#{disp.disciplina.nome}") if disp && disp.disciplina
  end
end
