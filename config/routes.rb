Rails.application.routes.draw do
  resources :friendship_requests
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :session
  resources :notes
  resources :user_notes
  root :to => "session#new"
  
  #get 'session/new'

  #get 'session/create'

  #get 'session/destroy'

  #resources :friends
  #resources :collection_users
  #resources :collection_notes
  #resources :collections
  #resources :user_notes
  #resources :notes
  #resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
