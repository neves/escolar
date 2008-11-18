require File.dirname(__FILE__) + '/../spec_helper'

describe Previsao do
  before(:each) do
    
  end
  
  it "should have a valid factory" do
    Factory(:previsao).should be_valid
  end
  
  describe "por_escola_por_cliente" do
    before(:each) do
      @escola_1 = Factory(:escola)
      @escola_2 = Factory(:escola)
      @cliente_1 = Factory(:aluno)
      @cliente_2 = Factory(:aluno)
      @p_1 = Factory(:previsao, :escola => @escola_1, :cliente => @cliente_1)
      @p_2 = Factory(:previsao, :escola => @escola_1, :cliente => @cliente_1)
      @p_3 = Factory(:previsao, :escola => @escola_1, :cliente => @cliente_2)
      @p_4 = Factory(:previsao, :escola => @escola_2, :cliente => @cliente_1)
      @p_5 = Factory(:previsao, :escola => @escola_2, :cliente => @cliente_1)
      @p_6 = Factory(:previsao, :escola => @escola_2, :cliente => @cliente_2)
    end
    
    it "deve encontrar as previsoes por escola e por cliente" do
      Previsao.por_escola_por_cliente(@escola_1, @cliente_1).should == [@p_1, @p_2]
    end
  end
  
  describe "por_escola_a_pagar" do
    before(:each) do
         
    end
    
    it "deve encontrar as previsoes de contas a pagar" do
      pending("estudar como é o relacionamento com fornecedores")
    end
  end
end
