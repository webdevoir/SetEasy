Rails.application.routes.draw do

resources :projects
devise_for :users

resources :locations, only: [:show, :new, :create, :edit, :update, :index, :destroy] do
	resources :rentals, only: [ :new, :create, :edit, :update, :destroy, :show, :index]
end
resources :crews, only: [:show, :new, :create, :edit, :update, :index, :destroy] do
	get :crew_events
end
resources :budgets, only: [:show, :new, :create, :edit, :update, :index, :destroy]
resources :events

root to: 'pages#landing'

# get 'rentals' => 'rentals#index', as: :rentals
# get 'rental' => 'rentals#show', as: :rental

resources :rentals, only: [:index] do
	get :sets, :on => :collection
end
get "/pages/:page" => "pages#show"

end
