class ProfessoresController < ApplicationController
	before_filter :find_professor, :except => [:index, :matriz_habilitacoes, :new, :create]

	def new
		@professor = current_escola.professores.new
	end

	def update
		current_escola.professores.update(params[:id], params[:professor])
		redirect_to professores_path
	end
	
	def create
		current_escola.professores.create(params[:professor])
		redirect_to professores_path
	end
	
	def destroy
		current_escola.professores.delete(params[:id])
		redirect_to professores_path
	end

	def index
		@professores = current_escola.professores.all
	end

	def habilitacoes
		@disciplinas = Disciplina.all
		@habilitadas = @professor.disciplina_ids
	end

	def habilitar
		@professor.disciplina_ids = (params[:professor][:disciplina_ids] rescue [])
		flash[:notice] = "Habilitações Salvas!"
		redirect_to :back
	end

	def disponibilidades
		@feiras = Feira.all
    	@horas = Hora.all
    	@disponibilidades = @professor.disponibilidades.index_by(&:horario_id)
	end

	def disponibilizar
		@professor.horario_ids = (params[:professor][:horario_ids] rescue [])
	    flash[:notice] = "Horários Salvas!"
	    redirect_to :back
	end

  	def matriz_habilitacoes
    	@professores = current_escola.professores.find(:all, :include => :disciplinas)

    	if request.get?
	      @disciplinas = Disciplina.find(:all, :order => :nome)
    	end

    if request.put?
      matriz = params[:professores] || {}
      @professores.each do |prof|
        prof.disciplina_ids = matriz[prof.id.to_s] || []
      end
      flash[:notice] = "Habilitações Salvas!"
      redirect_to :back
    end
  end

	private
	def find_professor
		@professor = current_escola.professores.find params[:id]
	end
end
