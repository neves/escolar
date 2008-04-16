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

=begin
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
=end
end

