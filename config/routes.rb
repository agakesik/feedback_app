Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/help', to: 'pages#help'
  get '/admin', to: 'pages#admin'
  resources :users
  resources :users do
    get 'toggle_activating', :on => :member
    get 'change_skater_status', :on => :member
  end
  resources :skills
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :account_activations, only: [:edit, :update]
  resources :ratings, only: [:new, :create, :destroy]
  resources :ratings do
    get 'add_new_rating'
  end
  get 'add_new_rating', to: 'ratings#add_new_rating'
  get '/all-ratings', to: 'ratings#all'
  resources :password_resets, only: [:new, :create, :edit, :update]
end
