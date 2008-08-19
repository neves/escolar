class PlanosController < ApplicationController
  # GET /planos
  # GET /planos.xml
  def index
    @planos = Plano.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planos }
    end
  end

  # GET /planos/1
  # GET /planos/1.xml
  def show
    @plano = Plano.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plano }
    end
  end

  # GET /planos/new
  # GET /planos/new.xml
  def new
    @plano = Plano.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plano }
    end
  end

  # GET /planos/1/edit
  def edit
    @plano = Plano.find(params[:id])
  end

  # POST /planos
  # POST /planos.xml
  def create
    @plano = Plano.new(params[:plano])

    respond_to do |format|
      if @plano.save
        flash[:notice] = 'Plano was successfully created.'
        format.html { redirect_to(@plano) }
        format.xml  { render :xml => @plano, :status => :created, :location => @plano }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plano.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planos/1
  # PUT /planos/1.xml
  def update
    @plano = Plano.find(params[:id])

    respond_to do |format|
      if @plano.update_attributes(params[:plano])
        flash[:notice] = 'Plano was successfully updated.'
        format.html { redirect_to(@plano) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plano.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planos/1
  # DELETE /planos/1.xml
  def destroy
    @plano = Plano.find(params[:id])
    @plano.destroy

    respond_to do |format|
      format.html { redirect_to(planos_url) }
      format.xml  { head :ok }
    end
  end
end
