Rails.application.routes.draw do

  #FRIEND REQUEST
  resources :friendship_requests
  post "friendship_requests/:name" => "friendship_requests#acceptFriendshipRequest"
  
  #USERS
  get "logout" => "session#destroy", :as => "logout"
  get "login" => "session#new", :as => "login"
  post "login" => "session#create"
  get "signup" => "users#new", :as => "signup"
  get "users/newuser" => "users#newuser", :as => "users/newuser"
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
  post "notes/:name" => 'notes#admin_destroy'
	
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
  resources :collections do
    collection do
	  get ':name/adminshare' => "collections#adminshare"
    end
  end
  get "allcollections" => "collections#allcollections"
  get "collections/:name/notes" => "collections#show_notes_collection"
  get "collections/:name/addnote" => "collections#addnote"
  get "collections/:name/addnote/:name" => "collections#save"
  

  
  #FRIENDS
  post "friends/destroyFriend"
  resources :friends  
  get "allfriends" => "friends#allfriends"
  #get "friends" => "friends#getFriends"
  
  #post 'user/:name' => 'user#acceptFriendshipRequest'
  
  
  #get 'session/new'

  #get 'session/create'

  #get 'session/destroy'

  #COLLECTIONS-USERS
  resources :collection_users
  
  #COLLECTIONS-NOTES
  resources :collection_notes
  
  resources :collections do
    collection do
	  get ':name/delete/:id' => "collections#destroyNoteFromCollection"
    end
  end  
 # post "collections/destroyNoteFromCollection"


end
