Rails.application.routes.draw do
  post 'videos/create'
  get 'videos/index'
  get 'users', to: 'users#index'
  post 'signup', to: 'users#create'
  post 'login', to: 'sessions#create'
end
