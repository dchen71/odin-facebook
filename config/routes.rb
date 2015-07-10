Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: "registrations"}
  resources :posts
  resources :comments

  resources :users, only: [:index, :show] do
    member do
      get :friends
      get :invites
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :invites, only: [:create, :destroy]

  get 'users/:id' => 'users#show'
  get 'users/:id/friends' => "relationships#index", as: 'friend_list'
  root 'static_pages#index'

end
