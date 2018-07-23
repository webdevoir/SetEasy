Rails.application.routes.draw do

		################  Admin Start#############################
		namespace :admin do
			resources :dashboard, only: [:landing]
	
			  root to: "/admin/dashboard#landing"
			devise_scope :user do
		      resources :users
		    end

		end 
		################  Admin End #############################

		resources :projects do
		  resources :project_users, path: :users, module: :projects
		end

		resources :plans do
			get :manage, :on => :collection
		end
		resources :subscriptions
		# devise_for :users

		resources :locations, only: [:show, :new, :create, :edit, :update, :index, :destroy] do
			resources :rentals, only: [ :new, :create, :edit, :update, :destroy, :show, :index]
		end
		resources :crews, only: [:show, :new, :create, :edit, :update, :index, :destroy] do
			get :crew_events
		end
		resources :budgets, only: [:show, :new, :create, :edit, :update, :index, :destroy] do
			get :pdfs, :on => :collection
		end
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
	 	resources :messages, only: [:new, :create]
	 	
		devise_for :users, controllers: {
		        sessions: 'user/sessions',
		        registrations: 'user/registrations',
		        invitations: 'user/invitations'
		      }

	end
