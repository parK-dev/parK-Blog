# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#home'

  # Provides all RESTful routes
  resources :articles
  resources :users, except: [:new]
  resources :categories

  # Provides all non-RESTful routes
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
