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
    resources :users do
    collection do
	  get 'search/:name' => "users#search"
    end
  end
  
  #NOTES
  
  resources :notes
  get "allnotes" => "notes#allnotes"
  delete 'note' => 'notes#destroy'
  resources :notes do
    collection do
	  get ':name/share' => "notes#share"
    end
  end
  
  #USER NOTES
  resources :user_notes
  root :to => "session#new"
  
  #COLLECTIONS
  resources :collections
  
  #FRIENDS

  #get "friends" => "friends#getFriends"
  resources :friends  
  
  
  #get 'session/new'

  #get 'session/create'

  #get 'session/destroy'

  #resources :collection_users
  #resources :collection_notes


end
