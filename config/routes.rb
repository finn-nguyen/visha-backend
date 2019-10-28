Rails.application.routes.draw do
  get 'users', to: 'users#index'
  post 'signup', to: 'users#create'
  post 'login', to: 'sessions#create'
end
