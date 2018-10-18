Rails.application.routes.draw do
  root 'games#index'

  resources :games, only: [:index, :show, :new, :create]
end
