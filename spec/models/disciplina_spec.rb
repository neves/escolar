require File.dirname(__FILE__) + '/../spec_helper'

describe Disciplina do
	 fixtures :disciplinas

	 it "deve ser instância da classe correta" do
		 disciplinas(:abstrata).should be_an_instance_of(Disciplina)
		 disciplinas(:normal).should be_an_instance_of(DisciplinaNormal)
		 disciplinas(:fixa).should be_an_instance_of(DisciplinaFixa)
	 end

	 it "deve ser abstrata a classe Disciplina, posso salvar apenas as filhas concretas" do

	 end
	 
   it "Deve retornar apenas Disciplinas Fixas" do
     Disciplina.fixa(:all).length.should == 1
     Disciplina.find(:all).length.should == 4
   end
   
   it "Deve retornar apenas Disciplinas Normais" do
      Disciplina.normal(:all).length.should == 2
      Disciplina.find(:all).length.should == 4
    end
end
