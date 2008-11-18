require File.dirname(__FILE__) + '/../spec_helper'

describe PrevisoesController do
  
  describe "index action" do
    before(:each) do
      
    end
    
    it "deve pesquisar contas a receber caso seja passado o id do cliente" do
      Previsao.should_receive(:por_escola_por_cliente).with("1").and_return([mock_model(Previsao), mock_model(Previsao)])
      get 'index', :cliente_id => "1"
    end
    
    it "deve pesquisar contas a pagar caso nao seja passado nenhum argumento para pesquisa" do
      Previsao.should_receive(:por_escola_a_pagar).and_return([mock_model(Previsao)])
      get 'index'
    end
    
    it "deve exibir o template previsoes/index.html.erb" do
      get 'index'
      response.should render_template("index")
    end
  end
end
