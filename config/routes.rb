Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/help', to: 'pages#help'
  get '/menu', to: 'pages#menu'
  get '/admin', to: 'pages#admin'
  resources :users
  resources :users do
    get 'toggle_activating', :on => :member
  end
  resources :skills
  resources :ratings, only: [:new, :create, :destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit, :update]
end
