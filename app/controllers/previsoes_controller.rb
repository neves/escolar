class PrevisoesController < ApplicationController
  layout 'application'
  # GET /previsoes
  # GET /previsoes.xml
  def index
    if params[:cliente_id]        
      @aluno = Aluno.find(params[:cliente_id])
      @previsoes = Previsao.por_escola_por_cliente(current_escola, @aluno)
    else
      @previsoes = Previsao.por_escola_a_pagar(current_escola)
    end    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @previsoes }
    end
  end  
end
