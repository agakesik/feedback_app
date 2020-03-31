Rails.application.routes.draw do
  get 'skills/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/help', to: 'pages#help'
  get '/menu', to: 'pages#menu'
  resources :users
  resources :skills
end
