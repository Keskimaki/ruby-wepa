Rails.application.routes.draw do
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'

  root "breweries#index"
end
