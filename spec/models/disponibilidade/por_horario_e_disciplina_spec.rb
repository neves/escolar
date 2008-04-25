require File.dirname(__FILE__) + '/../../spec_helper'

describe "Disponibilidade.por_horario_e_disciplina" do

  @professor = Professor.create(:apelido =>  'Neves')
  @disciplina = Disciplina.create(:nome => 'Lab', :fixa => false)


  it "deve retornar apenas professores habilitados" do

  end
end
