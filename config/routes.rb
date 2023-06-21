Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  get '/posts/new', to: 'posts#new', as: 'new_post'
  post '/posts/new', to: 'posts#create', as: 'create_post'
  post 'comments/new', to: 'comments#create', as: 'create_comment'
  post 'likes/new', to: 'likes#create', as: 'create_like'
end
