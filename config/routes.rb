Rails.application.routes.draw do
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  get '/posts', to: 'posts#index'
  get '/posts/:id', to: 'posts#show'
end
