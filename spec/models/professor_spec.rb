require File.dirname(__FILE__) + '/../spec_helper'

describe Professor do
   fixtures :professores, :disciplinas

	 it "deve receber habilitacoes de disciplinas" do
		 neves = professores(:neves)
		 neves.disciplina_ids = [2, 3]
		 neves.save
		 neves = professores(:neves)
		 neves.habilitacoes.size.should == 2
		 neves.disciplinas.collect(&:class).should == [DisciplinaNormal, DisciplinaFixa]
	 end
end
