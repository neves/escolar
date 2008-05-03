ActionController::Routing::Routes.draw do |map|
	map.resources :professores, 
								:member => {
									:habilitacoes => :get,
									:habilitar => :put,

									:disponibilidades => :get,
									:disponibilizar => :put
								},
                # precisa ser collection para ficar: /professores/matriz_habilitacoes
                # se for member, fica /professores/1/matriz_habilitacoes
                :collection => {
                  :matriz_habilitacoes => :any
                }

	map.resources :disciplinas,
								:member => {
									:disponibilidades => :get,
	                :disponibilizar => :put
								}

  map.resource :planilha, :member => {:agendar => :get} do |planilha|
    #namespace também funciona
    planilha.resources :turmas, :controller => 'Planilhas::Turmas' do |turma|
      turma.resources :alunos, :controller => 'Planilhas::Turmas::Alunos'
      turma.resources :aulas, :controller => 'Planilhas::Turmas::Aulas'
    end
  end

  map.resources :alunos
  map.resources :turmas

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
