class MatriculasController < ApplicationController
  before_filter :find_aluno, :only => [:new, :create]

  # GET /matriculas
  # GET /matriculas.xml
  def index
    @matriculas = Matricula.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matriculas }
    end
  end

  # GET /matriculas/1
  # GET /matriculas/1.xml
  def show
    @matricula = Matricula.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @matricula }
    end
  end

  # GET /matriculas/new
  # GET /matriculas/new.xml
  def new
    @matricula = current_escola.matriculas.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @matricula }
    end
  end

  # GET /matriculas/1/edit
  def edit
    @matricula = Matricula.find(params[:id])
  end

  # POST /matriculas
  # POST /matriculas.xml
  def create
  	params[:matricula][:escola_id] = current_escola_id
  	params[:matricula][:user_id] = current_user.id
    @matricula = @aluno.matriculas.new(params[:matricula])

    respond_to do |format|
      if @matricula.save
        flash[:notice] = 'Matricula Gerada!'
        format.html { redirect_to(alunos_path) }
        format.xml  { render :xml => @matricula, :status => :created, :location => @matricula }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @matricula.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matriculas/1
  # PUT /matriculas/1.xml
  def update
    @matricula = Matricula.find(params[:id])

    respond_to do |format|
      if @matricula.update_attributes(params[:matricula])
        flash[:notice] = 'Matricula was successfully updated.'
        format.html { redirect_to(@matricula) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @matricula.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matriculas/1
  # DELETE /matriculas/1.xml
  def destroy
    @matricula = Matricula.find(params[:id])
    @matricula.destroy

    respond_to do |format|
      format.html { redirect_to(matriculas_url) }
      format.xml  { head :ok }
    end
  end

	private
	def find_aluno
		@aluno = current_escola.alunos.find params[:aluno_id]
	end
end
