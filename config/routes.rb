Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  # resources :messages, only: [:new, :create]
  resources :nodes, only: [:new, :show]
  # resources :comments, only: [:create, :destroy]
  
  get "users/:nickname", to: "users#info", as: :user
  get "users/:nickname/comments", to: "users#comments_list", as: :user_comments
  get "users/:nickname/notifications", to: "notifications#index", as: :user_notifications
  get "ajax/users/search", to: "users#search"
  post "ajax/posts/preview", to: "posts#preview"

  get "messages/:to_user_nickname", to: "messages#new", as: :new_message
  post "messages/:to_user_nickname", to: "messages#create", as: :messages

  post "likes/:data_type/:data_id", to: "likes#create", as: :new_like
  delete "likes/:data_type/:data_id", to: "likes#destroy", as: :destroy_like

  root "home#index"

  # get "/login", to: "sessions#new"
  # post "/login", to: "sessions#create"
  # delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
