require File.dirname(__FILE__) + '/../spec_helper'

describe Disciplina do
	 fixtures :disciplinas

	 it "deve ter o nome, type e apelido padrao, igual à 'Disciplina'" do
		 Disciplina.new.nome.should == 'Disciplina'
		 Disciplina.new.type.should == 'Disciplina'
		 Disciplina.new.apelido.should == 'Disciplina'
	 end

	 it "deve ser instância da classe correta" do
		 disciplinas(:abstrata).should be_an_instance_of(Disciplina)
		 disciplinas(:normal).should be_an_instance_of(DisciplinaNormal)
		 disciplinas(:fixa).should be_an_instance_of(DisciplinaFixa)
		 Disciplina.all.collect(&:class).should == [Disciplina, DisciplinaNormal, DisciplinaFixa]
	 end
end
