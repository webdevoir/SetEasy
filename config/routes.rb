Rails.application.routes.draw do

resources :locations, only: [:new, :create, :edit, :update, :index, :destroy]

root to: 'locations#index'

end
