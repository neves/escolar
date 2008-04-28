ActionController::Routing::Routes.draw do |map|
	map.resources :professores, 
								:member => {
									:habilitacoes => :get, 
									:habilitar => :put,

									:disponibilidades => :get,
									:disponibilizar => :put
								},
                :collection => {
                  :matriz_habilitacoes => :any
                }

	map.resources :disciplinas,
								:member => {
									:disponibilidades => :get,
	                :disponibilizar => :put
								}

  map.resource :planilha,
               :member => {
                 :agendar => :get
               }

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
