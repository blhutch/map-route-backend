Rails.application.routes.draw do
  
scope defaults: { format: 'json'} do

  post 'users/login', to: 'users#login'
  post 'users/register', to: 'users#register'

  resources :trips, only: [:create, :index] do
  	resources :locations , only: [:create, :index]
  end

  post 'trips/:trip_id/optimize', to: 'trips#optimize'

end

end
