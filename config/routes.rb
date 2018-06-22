Rails.application.routes.draw do
		namespace :admin do
			resources :dashboard, only: [:landing]
	
			  root to: "/admin/dashboard#landing"
		end

		resources :projects

		resources :plans
		resources :subscriptions
		# devise_for :users

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

		# devise_scope :user do
	 #      root to: "devise/sessions#new"
	 #    end

		devise_for :users, controllers: {
		        sessions: 'user/sessions',
		        registrations: 'user/registrations',
		      }

	end
