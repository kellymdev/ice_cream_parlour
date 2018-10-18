Rails.application.routes.draw do
  root 'games#index'

  resources :games, only: [:index, :show, :new, :create, :destroy] do
    resources :days, only: [:new, :create]
  end
end
