Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :users
  resources :posts
  delete "remove_attachment", to: 'posts#remove_attachment_posts'
  resources :categories
  post 'posts/:id/flag', to: 'posts#increment_flag', as: :increment_flag
  get 'login', to: 'sessions#new', as: :login
  post 'auth', to: 'sessions#create', as: :auth
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'posts#index'
  get '/about', to: 'home#about'

  post 'admin/post/:id/aprpove', to: 'admin/posts#approve', as: :admin_post_approve
end