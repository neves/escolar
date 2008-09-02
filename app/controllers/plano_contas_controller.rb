class PlanoContasController < ApplicationController
  # GET /plano_contas
  # GET /plano_contas.xml
  def index
    @plano_contas = PlanoConta.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plano_contas }
    end
  end

  # GET /plano_contas/1
  # GET /plano_contas/1.xml
  def show
    @plano_conta = PlanoConta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plano_conta }
    end
  end

  # GET /plano_contas/new
  # GET /plano_contas/new.xml
  def new
    @plano_conta = PlanoConta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plano_conta }
    end
  end

  # GET /plano_contas/1/edit
  def edit
    @plano_conta = PlanoConta.find(params[:id])
  end

  # POST /plano_contas
  # POST /plano_contas.xml
  def create
    @plano_conta = PlanoConta.new(params[:plano_conta])

    respond_to do |format|
      if @plano_conta.save
        flash[:notice] = 'PlanoConta was successfully created.'
        format.html { redirect_to(@plano_conta) }
        format.xml  { render :xml => @plano_conta, :status => :created, :location => @plano_conta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plano_conta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plano_contas/1
  # PUT /plano_contas/1.xml
  def update
    @plano_conta = PlanoConta.find(params[:id])

    respond_to do |format|
      if @plano_conta.update_attributes(params[:plano_conta])
        flash[:notice] = 'PlanoConta was successfully updated.'
        format.html { redirect_to(@plano_conta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plano_conta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plano_contas/1
  # DELETE /plano_contas/1.xml
  def destroy
    @plano_conta = PlanoConta.find(params[:id])
    @plano_conta.destroy

    respond_to do |format|
      format.html { redirect_to(plano_contas_url) }
      format.xml  { head :ok }
    end
  end
end
