Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'users#index'
  get '/users/:id', to: 'users#show'

  get '/users/new/posts', to: 'posts#new'
  post '/users/new/posts/create', to: 'posts#create'

  get '/users/:user_id/posts', to: 'posts#index', as: :user_posts
  get '/users/:user_id/posts/:id', to: 'posts#show'

  get '/users/:id/posts/:post_id/comments/new', to: 'comments#new'
  post '/users/:id/posts/:post_id/comments/create', to: 'comments#create'

  post '/users/:id/posts/:post_id/likes/create', to: 'likes#create'
end
