Rails.application.routes.draw do
  post 'videos', to: 'videos#create'
  get 'users', to: 'users#index'
  post 'signup', to: 'users#create'
  post 'login', to: 'sessions#create'
end
