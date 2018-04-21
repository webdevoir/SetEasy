Rails.application.routes.draw do

devise_for :users
resources :rentals, only: [:show, :new, :create, :edit, :update, :index, :destroy]
resources :locations, only: [:show, :new, :create, :edit, :update, :index, :destroy]
resources :crews, only: [:show, :new, :create, :edit, :update, :index, :destroy]

root to: 'pages#landing'

get "/pages/:page" => "pages#show"

end
