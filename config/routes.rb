Rails.application.routes.draw do

  #FRIEND REQUEST
  resources :friendship_requests
  
  #USERS
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :session
  
  #NOTES
  
  resources :notes
  get "allnotes" => "notes#allnotes"
  delete 'note' => 'notes#destroy'
  
  #USER NOTES
  resources :user_notes
  root :to => "session#new"
  
  #COLLECTIONS
  resources :collections
  
  #FRIENDS
  resources :friends
  
  
  
  #get 'session/new'

  #get 'session/create'

  #get 'session/destroy'

  #resources :collection_users
  #resources :collection_notes


end
