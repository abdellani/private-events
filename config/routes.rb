# frozen_string_literal: true

Rails.application.routes.draw do
  get 'events/new'
  root 'events#index'

  resources :users, only: %i[new create show index]
  resources :events, only: %i[new create show index]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'attendances', to: 'attendances#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
