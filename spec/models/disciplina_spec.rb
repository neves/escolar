require File.dirname(__FILE__) + '/../spec_helper'

describe Disciplina do
		before(:each) do
			@disciplina = Disciplina.create :fixa => true, :nome => 'Laboratório', :apelido => 'lab'
			@professor = Professor.create :nome => 'Neves'
			h = Horario.new
			h.id = 108
			h.save
			h = Horario.new
			h.id = 614
			h.save
			@professor.horario_ids = [108, 614]
			@professor.disciplinas << @disciplina
		end

	 # INICIO DOS TESTES QUE VOU REUTILIZAR ABAIXO
	 it "deve ter professores habilitados" do
			@disciplina.professores(true).should_not be_empty
	 end

	 it "não deve ter nenhuma reserva" do
		 @disciplina.disponibilidades.count.should == 0
	 end

	 it "não deve ter reservas agrupada por horario" do
		 @disciplina.reservas_agrupadas_por_horario.should be_empty
	 end

	 it "deve existir professores disponiveis" do
		@professor.disponibilidades(true).count.should == 2
	 end

	 it "deve existir professor sem horarios reservados" do
		 @professor.disponibilidades.reservadas.count.should == 0
	 end

	 it "deve exisitr professor com todos horarios livres" do
     @professor.disponibilidades.livres.count.should == 2
   end
	 # FIM

	  describe "ao agendar" do
			before(:each) do
				@disciplina.disponibilidades << @professor.disponibilidades.first
			end

			it "deve ter disponibilidades" do
				@disciplina.disponibilidades(true).count.should == @professor.disponibilidades.count - 1
				@professor.disponibilidades(true).count.should == 2
				@disciplina.disponibilidades.first.should == @professor.disponibilidades.first
			end

			it "a disponibilidade do professor deve ter disciplina_id" do
				@professor.disponibilidades(true).first.disciplina = @disciplina
			end

      it "a disponibilidade do professor deve continuar 2" do
        @professor.disponibilidades(true).count.should == 2
      end

			it "a disponibilidade fixa do professor, deve ser 1" do
				@professor.disponibilidades(true).reservadas.count.should == 1
			end

      it "a disponibilidade normal do professor, deve ser 1" do
        @professor.disponibilidades(true).livres.count.should == 1
      end

			it "deve ter as reservas agrupada por horario" do
				hash = @disciplina.reservas_agrupadas_por_horario
				hash.should have(1).item
				hash.should have_key(108)
				hash.should_not have_key(614)
				hash[108].should be_an_instance_of(Disponibilidade)
			end

			describe "ao des-agendar" do
      	before(:each) do
		        @disciplina.disponibilidades = []
				end

	 # INICIO PARTE REPETIDA
   it "deve ter professores habilitados" do
      @disciplina.professores(true).should_not be_empty
   end

   it "não deve ter nenhuma reserva" do
     @disciplina.disponibilidades.count.should == 0
   end

   it "não deve ter reservas agrupada por horario" do
     @disciplina.reservas_agrupadas_por_horario.should be_empty
   end

   it "deve existir professores disponiveis" do
    @professor.disponibilidades(true).count.should == 2
   end

   it "deve existir professor sem horarios reservados" do
     @professor.disponibilidades.reservadas.count.should == 0
   end

   it "deve exisitr professor com todos horarios livres" do
     @professor.disponibilidades.livres.count.should == 2
   end
	 # FIM PARTE REPETIDA

			end
		end
end
