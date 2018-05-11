Rails.application.routes.draw do
  resources :friendship_requests
  get 'session/new'

  get 'session/create'

  get 'session/destroy'

  resources :friends
  resources :collection_users
  resources :collection_notes
  resources :collections
  resources :user_notes
  resources :notes
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
