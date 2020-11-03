Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :posts do
    resources :comments, only: [:create, :edit, :update]
  end
  resources :nodes, only: [:new, :show]
  # resources :comments, only: [:create, :destroy]
  
  get "users/:id", to: "users#info", as: :user
  get "users/:id/comments", to: "users#comments_list", as: :user_comments

  root "home#index"

  # get "/login", to: "sessions#new"
  # post "/login", to: "sessions#create"
  # delete "/logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
