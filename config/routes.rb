Rails.application.routes.draw do
  get 'users/create'
  get 'sessions/create'
  get 'sessions/destroy'

  post 'signup', to: 'users#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
