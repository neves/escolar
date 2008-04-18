require File.dirname(__FILE__) + '/../spec_helper'

describe Professor do
=begin
   fixtures :professores, :disciplinas, :horarios

	 it "deve receber habilitacoes de disciplinas" do
		 neves = professores(:neves)
		 neves.disciplina_ids = [2, 3]
		 neves.save
		 neves = professores(:neves)
		 neves.habilitacoes.size.should == 2
		 neves.disciplinas.collect(&:class).should == [DisciplinaNormal, DisciplinaFixa]
	 end

	 it "disponibilidades_normais deve criar instancia do tipo DisponibilidadeNormal" do
			neves = professores(:neves)
			neves.horario_ids = [108, 614]
			neves = professores(:neves)
			neves.horarios.collect(&:id).should == [108, 614]
			neves.disponibilidades.collect(&:class).should == [DisponibilidadeNormal, DisponibilidadeNormal]
	 end

	 it "deve criar disponibilizacoes normais atraves de horario_ids" do
		 ids = [108, 614]
		 Horario.all.collect(&:id).should == ids
		 neves = professores(:neves)
		 neves.horario_ids = ids
		 neves.save
		 neves = professores(:neves)
		 neves.horarios.collect(&:id).should == ids
	 end
=end
end
