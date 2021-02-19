Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Provides all the RESTful routes to articles
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]  
end
