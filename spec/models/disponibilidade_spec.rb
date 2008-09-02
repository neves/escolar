require File.dirname(__FILE__) + '/../spec_helper'

describe Disponibilidade do
	before(:each) do
  	Disponibilidade.create(:professor_id => 1, :horario_id => 108)
		Disponibilidade.create(:professor_id => 1, :horario_id => 614, :disciplina_id => 1)
	end
	it "todas" do
		Disponibilidade.count.should == 2
	end
	it "reservadas" do
		Disponibilidade.reservadas.count.should == 1
	end
	it "livres" do
		Disponibilidade.livres.count.should == 1
	end
end

describe Disponibilidade, ".ocupadas" do
  before(:each) do
    @professor = Professor.new
    Disponibilidade.create(:professor => @professor)
    Disponibilidade.create(:professor => @professor, :ocupada => true)
    Disponibilidade.create(:ocupada => true)
  end


  it "deve filtrar corretamente" do
    # @FIXME  não funciona com named_scope
    #Disponibilidade.should_receive(:find).with(:all, :conditions => {:ocupada => true})
    #Disponibilidade.ocupadas
    
    # @FIXME se eu criar alguma valdation no model, este teste irá quebrar
    Disponibilidade.ocupadas.collect(&:id).should == [2, 3]
    Disponibilidade.nao_ocupadas.collect(&:id).should == [1]
  end


  it ".ocupadas no escopo do professor" do
    @professor.disponibilidades.ocupadas.collect(&:id).should == [2]
    @professor.disponibilidades.nao_ocupadas.collect(&:id).should == [1]
    @professor.disponibilidades.nao_ocupadas.livres.collect(&:id).should == [1]
  end
  
  it %(
  ao virar fixa, deve ocupar as horas sequentes baeado na duracao da disciplina,
  ou seja, se agendar uma aula fixa de 3 horas às 10h, deve ocupar as disponibilidades das 11h e 12h
  ) do
=begin    
    prof = Professor.new
    disp = mock("disp")
    disp.should_receive(:find).with(:all, :conditions => {:hora => 11..12}
    prof.should_receive(:disponibilidades).and_return(disp)
    Disponibilidade.should_receive(:professor).and_return(prof)
    Disponibilidade.create(:professor => prof)
    prof.horarios << Horario.find(110)
=end
  end
end
