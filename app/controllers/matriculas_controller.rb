class MatriculasController < ApplicationController
  before_filter :find_aluno, :only => [:new, :create, :show]

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
    @matricula = current_escola.matriculas.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @matricula }
    end
  end

  # GET /matriculas/new
  # GET /matriculas/new.xml
  def new
    @matricula = current_escola.matriculas.new
	@parcelas = []
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @matricula }
    end
  end

  # POST /matriculas
  # POST /matriculas.xml
  def create
  	params[:matricula][:escola_id] = current_escola_id
  	params[:matricula][:user_id] = current_user.id
  	if params[:matricula][:valor_seg_parcela_matricula].blank?
  		begin
	  		plano = Plano.find params[:matricula][:plano_id]
	  		params[:matricula][:valor_pri_parcela_matricula] = plano.valor_matricula
  		rescue
  		end
  	end
  	params[:matricula]["data_inicio_parcelas(3i)"] = params[:matricula][:dia_vcto_parcelas]
    @matricula = @aluno.matriculas.new(params[:matricula])
	@parcelas = []
    respond_to do |format|
      if params[:preview]
      	@matricula.valid?
      	@parcelas = @matricula.gerar_financeiro(false)
      	format.html { render :action => "new" }
      elsif @matricula.save
        flash[:notice] = 'Matricula Gerada!'
        format.html { redirect_to(alunos_path) }
        format.xml  { render :xml => @matricula, :status => :created, :location => @matricula }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @matricula.errors, :status => :unprocessable_entity }
      end
    end
  end

	private
	def find_aluno
		@aluno = current_escola.alunos.find params[:aluno_id]
	end
end
