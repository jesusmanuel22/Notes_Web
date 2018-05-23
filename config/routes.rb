Rails.application.routes.draw do

  #FRIEND REQUEST
  resources :friendship_requests
  post "friendship_requests/:name" => "friendship_requests#acceptFriendshipRequest"
  
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
  post "users/sendFriendRequest"
  get "profile" => "users#profile", :as => "profile"
  
  #NOTES
  resources :notes
  get "allnotes" => "notes#allnotes"
  delete 'note' => 'notes#destroy'
  resources :notes do
    collection do
	  get ':name/share' => "notes#share"
    end
  end  
  resources :notes do
    collection do
	  get ':name/adminshare' => "notes#adminshare"
    end
  end
  
  #USER NOTES
  resources :user_notes
  root :to => "session#new"
  
  #COLLECTIONS
  resources :collections
  resources :collections do
    collection do
	  get ':name/share' => "collections#share"
    end
  end
  get "allcollections" => "collections#allcollections"
  
  #FRIENDS
  post "friends/destroyFriend"
  #get "friends" => "friends#getFriends"
  resources :friends  
  #post 'user/:name' => 'user#acceptFriendshipRequest'
  
  
  #get 'session/new'

  #get 'session/create'

  #get 'session/destroy'

  resources :collection_users
  #resources :collection_notes


end
