ActionController::Routing::Routes.draw do |map|
  map.resources :plano_contas

  map.resources :previsoes

  map.resources :matriculas

  map.resources :planos, :member => {:valor_matricula => :get, :valor_mensalidade => :get}

  map.resources :cursos

  map.resources :users, :member => {:suspend => :put, :unsuspend => :put, :purge => :delete}
  map.resource :session
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.logar '/logar', :controller => 'sessions', :action => 'create'

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

  map.resources :alunos, :collection => {:suggest => :get} do |aluno|
  	aluno.resources :matriculas
  end
  map.resources :turmas
  map.resource :route
  map.root :alunos

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
