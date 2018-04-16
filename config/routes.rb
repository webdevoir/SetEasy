Rails.application.routes.draw do

  get 'rentals/index'

  get 'rentals/show'

  get 'rentals/new'

  get 'rentals/edit'

resources :locations, only: [:show, :new, :create, :edit, :update, :index, :destroy]

root to: 'locations#index'

end
