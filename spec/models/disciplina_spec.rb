require File.dirname(__FILE__) + '/../spec_helper'

describe Disciplina do
  
  fixtures :disciplinas
  
  before(:each) do
    @disciplina = Disciplina.new
  end

  it "deve responder pelo relacionamento com habilitacoes" do
    @disciplina.respond_to?(:habilitacoes).should be_true
  end
  
  it "deve responder pelo relacionamento com professores" do
    @disciplina.respond_to?(:professores).should be_true
  end
  
  it "deve responder pelo relacionamento com disponibilidades" do
    @disciplina.respond_to?(:disponibilidades).should be_true
  end
  
  describe ".reservas_agrupadas_por_horario" do

    it "deve executar um find em disponibilidades e um index_by no resultado" do
      disponibilidade1 = mock("Disponibilidade 1")
      disponibilidade1.should_receive(:horario_id).and_return(1)
      disponibilidades_mock = [disponibilidade1]

      relacionamento_disponibilidades_mock = mock("Disponibilidades")
      relacionamento_disponibilidades_mock.should_receive(:find).with(:all, :include => :professor).and_return(disponibilidades_mock)
      
      @disciplina.should_receive(:disponibilidades).and_return(relacionamento_disponibilidades_mock)
      @disciplina.reservas_agrupadas_por_horario.should == { 1 => disponibilidade1}
    end

  end
  
  describe ".fixas" do
    
    it "deve ter definido named_scope fixas" do
      Disciplina.scopes[:fixas].should_not be_nil
    end
    
    it "deve levar em conta as conditions" do
      Disciplina.find(:all, :conditions => {:fixa => true}).should == Disciplina.fixas
    end
  
  end
  
  describe ".normais" do

    it "deve ter definido named_scope normais" do
      Disciplina.scopes[:normais].should_not be_nil
    end
    
    it "deve levar em conta as conditions" do
      Disciplina.find(:all, :conditions => {:fixa => false}).should == Disciplina.normais
    end
    

  end

end
