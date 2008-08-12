class ProfessoresController < ApplicationController
	before_filter :find_professor, :except => [:index, :matriz_habilitacoes, :new, :create]

	def new
		@professor = Professor.new
	end

	def update
		Professor.update(params[:id], params[:professor])
		redirect_to professores_path
	end
	
	def create
		Professor.create(params[:professor])
		redirect_to professores_path
	end
	
	def destroy
		Professor.delete(params[:id])
		redirect_to professores_path
	end

	def index
		@professores = Professor.all
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
    	@professores = Professor.find(:all, :include => :disciplinas)

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
		@professor = Professor.find params[:id]
	end
end
