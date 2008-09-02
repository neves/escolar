class PrevisoesController < ApplicationController
  # GET /previsoes
  # GET /previsoes.xml
  def index
    @previsoes = Previsao.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @previsoes }
    end
  end

  # GET /previsoes/1
  # GET /previsoes/1.xml
  def show
    @previsao = Previsao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @previsao }
    end
  end

  # GET /previsoes/new
  # GET /previsoes/new.xml
  def new
    @previsao = Previsao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @previsao }
    end
  end

  # GET /previsoes/1/edit
  def edit
    @previsao = Previsao.find(params[:id])
  end

  # POST /previsoes
  # POST /previsoes.xml
  def create
    @previsao = Previsao.new(params[:previsao])

    respond_to do |format|
      if @previsao.save
        flash[:notice] = 'Previsao was successfully created.'
        format.html { redirect_to(@previsao) }
        format.xml  { render :xml => @previsao, :status => :created, :location => @previsao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @previsao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /previsoes/1
  # PUT /previsoes/1.xml
  def update
    @previsao = Previsao.find(params[:id])

    respond_to do |format|
      if @previsao.update_attributes(params[:previsao])
        flash[:notice] = 'Previsao was successfully updated.'
        format.html { redirect_to(@previsao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @previsao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /previsoes/1
  # DELETE /previsoes/1.xml
  def destroy
    @previsao = Previsao.find(params[:id])
    @previsao.destroy

    respond_to do |format|
      format.html { redirect_to(previsoes_url) }
      format.xml  { head :ok }
    end
  end
end
