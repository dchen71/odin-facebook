Rails.application.routes.draw do
  devise_for :users
  resources :posts
  get 'users/:id' => 'users#show'

  resources :users, only: [:index, :show]

  root 'static_pages#index'

end
