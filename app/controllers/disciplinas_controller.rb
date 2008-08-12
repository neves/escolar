class DisciplinasController < ApplicationController
	before_filter :find_disciplina, :except => [:index, :new, :create]

  def index
    @disciplinas = Disciplina.find(:all, :order => "material_id, nome")
  end
  
  def new
  	@disciplina = Disciplina.new
  	@materiais = Material.all :order => :id
  end
  
  def edit
  	@materiais = Material.all :order => :id
  end
  
  def update
  	Disciplina.update(params[:id], params[:disciplina])
  	redirect_to disciplinas_path
  end

	def create
		Disciplina.create(params[:disciplina])
		redirect_to disciplinas_path
	end
	
	def destroy
		Disciplina.delete(params[:id])
		redirect_to disciplinas_path
	end

	def disponibilidades
		somente_disciplina_fixa!
		@feiras 	= Feira.all
		@horas 		= @disciplina.horas
		@vagas = Disponibilidade.agrupadas_por_horario_para_a_disciplina(@disciplina)
		@reservados = @disciplina.reservas_agrupadas_por_horario
	end

	def disponibilizar
		somente_disciplina_fixa!
    @disciplina.disponibilidade_ids = params[:disciplina][:disponibilidade_ids].reject(&:empty?)
    flash[:notice] = "Horários Salvas!"
    redirect_to :back
	end

	private

	def find_disciplina
		@disciplina = Disciplina.find params[:id]
	end

	def somente_disciplina_fixa!
		raise Exception.new("Apenas disciplinas fixas possuem horario fixo!") unless @disciplina.fixa?
	end
end
