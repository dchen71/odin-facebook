Rails.application.routes.draw do
  devise_for :users
  resources :posts
  get 'users/:id' => 'users#show'

  resources :users, only: [:index, :show] do
  	member do
  		get :friends
  		get :invites
  	end
  end
  resources :relationships, only: [:create, :destroy]
  resources :invites, only: [:create, :destroy]


  root 'static_pages#index'

end
