require File.dirname(__FILE__) + '/../spec_helper'

describe Disciplina do
	 fixtures :disciplinas, :habilitacoes, :professores, :horarios

	 it "deve ser instância da classe correta" do
		 disciplinas(:abstrata).should be_an_instance_of(Disciplina)
		 disciplinas(:normal).should be_an_instance_of(DisciplinaNormal)
		 disciplinas(:fixa).should be_an_instance_of(DisciplinaFixa)
	 end

	 it "deve ser abstrata a classe Disciplina, posso salvar apenas as filhas concretas" do

	 end

	 it "agendar 1 horario fixo com um professor habilitado" do
		fixa = disciplinas(:fixa)
		neves = fixa.professores.first

		describe "Professor Habilitado" do
			it "nome deve ser Neves" do
				neves.nome.should == "Neves"
			end

			it "deve ter 3 habilitacoes" do
				neves.habilitacoes.count.should == 3
			end

			it "deve estar disponivel segunda às 08 e sábado às 14 horas" do
				neves.horario_ids = [108, 614]
				neves.disponibilidades.collect(&:horario_id).should == [108, 614]
				neves.disponibilidade_ids.should == [1, 2]
			  #fixa.disponibilidade_fixa_ids = neves.disponibilidade_ids
			  fixa.disponibilidades = neves.disponibilidades

				#fixa = disciplinas(:fixa)
				neves = fixa.professores.first
				fixa.disponibilidades.should == neves.disponibilidades
				#neves.disponibilidades.first.class.should == DisponibilidadeNormal
				#fixa.disponibilidades.first.class.should == DisponibilidadeNormal
				neves.disponibilidades.first.disciplina_fixa_id.should == 3
			end

			it "deve manter os dados" do
				fixa.disponibilidades.length.should == 3
			end
		end
	end
end
