Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resource :posts
  resource :comments
  
  root :to => 'sessions#start'
  
  match '/signin', to: 'sessions#create', via: :post
  match '/session', to: 'sessions#create', via: :post
  match '/signup', to: 'users#new', via: :get
  match '/signout', to: 'sessions#destroy', via: :get
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/users/new', to: 'users#create', via: :post
end
