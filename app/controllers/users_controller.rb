class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :not_require_login, only: [:new]
  before_action :search, only: [:search]
  before_action :require_login, only: [:profile, :search]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  def profile
  
	@user = User.find_by name: session[:user]

	@numnotes = (ActiveRecord::Base.connection.execute("SELECT 'notes'.* FROM 'notes', 'user_notes' WHERE 'notes'.'id' == 'user_notes'.id_note AND 'user_notes'.id_user == #{@user.id}")).count

	@numfriends = Friend.where('id_user1 LIKE ? OR id_user2 LIKE ?',"#{@user.id}","#{@user.id}").count
	
    @numcollections = (CollectionUser.where('id_user LIKE ? ', "#{@user.id}")).count

  end
  
  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    user = User.find_by(name: user_params[:name])
    if user == nil
      if user_params[:password] == params[:rpassword]
        if user_params[:password]!= '' && user_params[:password]!=' '
          if @user.save
            redirect_to login_url, :notice => "Signed up!"
          else
            render :new
          end
        else
          redirect_to signup_url, :notice => "ERROR, Password can't be empty"
        end

      else 
        redirect_to signup_url, :notice => "ERROR, password must be equals"
      end
    else
      redirect_to signup_url, :notice => "ERROR username already exits!"
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def primerdestruir
    @user=User.find_by name: session[:user]
    #@notes = Note.where('user_id LIKE ?', "#{@user.id}")
    #@notes.each do |note|
     # note.destroy
    #end
    User.find(params[:id]).destroy
    redirect_to "/logout", :notice => "The user was successfully destroyed."
    
  end

  # SEARCH USER
  def search
    @user = Array.new
	if params[:name]
	  @users = User.where('name LIKE ?', "%#{params[:name]}%")
	  
	  @users.each do |user|
	    if user.name != session[:user]
		  @user.push(user)
	    end
	  end
	else
      @user = User.all
		
	  @users.each do |user|
		if user.name != session[:user]
		  @user.push(user)
        end
	  end
	end
  end
  
  
  #Send Request Friend
  def sendFriendRequest
    friendshipreqs=params[:friendshipreqs]
    @sender = (User.find_by name: session[:user])
    @existRequest = FriendshipRequest.where('sender LIKE ? AND receiver LIKE ? ',"#{friendshipreqs}","#{@sender.id}").count
    @existRequest2 = FriendshipRequest.where('sender LIKE ? AND receiver LIKE ? ',"#{@sender.id}","#{friendshipreqs}").count
    @existFriend = Friend.where('id_user1 LIKE ? AND id_user2 LIKE ? ',"#{friendshipreqs}","#{@sender.id}").count
    @existFriend2 = Friend.where('id_user1 LIKE ? AND id_user2 LIKE ? ',"#{@sender.id}","#{friendshipreqs}").count
    if(@existRequest==0 && @existRequest2==0 && @existFriend==0 && @existFriend2==0 )
      @request = FriendshipRequest.new
      @request.sender = @sender.id
      @request.receiver = friendshipreqs
      @request.text = "#{@sender.name} wants to be your friend"
      @request.expiration_date = "#{DateTime.now >> 1}"
      if @request.save
        redirect_to friends_url, :notice => "Request sended!"
      else
        render :new
      end
    else
      redirect_to notes_url, :notice => "This request exist!"
    end
    
    
  end
#Muestra las peticiones de amistad pendiente
  def showFriendsRequest
    @user=User.find_by name: session[:user]
    @friends = FriendshipRequest.where('receiver LIKE ?',"#{@user.id}")
    @finalFriends = Array.new
    @friends.each do |friend|

      if(DateTime.now > friend.expiration_date.to_date)
        friend.destroy
      else
        finalFriends.push(friend)
      end
    end
  end
  
  def numberFriendsRequest
    @numpetitions = FriendshipRequest.numberFriendsRequest
  end




  #Rechazar peticiones amistad
  def denialFriendshipRequest
    @user = (User.find_by name: session[:user])
    FriendshipRequest.where('sender LIKE ? AND receiver LIKE ? ',"#{@friendshipreqs.id}","#{@user.id}").destroy_all
    redirect_to :back
  end

def destroy
    #@user=User.find_by name: session[:user]

    #DELETE NOTES TOO

    @user_notes = UserNote.where('id_user LIKE ?', "#{@user.id}")
    @user_notes.each do |usernote|
      if UserNote.where('id_note LIKE ?', "#{usernote.id_note}").count == 1
        Note.find(usernote.id_note).destroy
      end

      usernote.destroy

    end


    #DELETE Collections
    @user_collections = CollectionUser.where('id_user LIKE ?', "#{@user.id}")
    @user_collections.each do |collectionuser|
      if CollectionUser.where('id_collection LIKE ?', "#{collectionuser.id_collection}").count == 1
        Collection.find(collectionuser.id_collection).destroy
        CollectionNote.where('id_collection LIKE ?', "#{collectionuser.id_collection}").destroy_all

      end

      collectionuser.destroy

    end


    ##################### QUEDA HACER LO MISMO CON LAS peticiones de amistad y amigs ###########################
    FriendshipRequest.where('sender LIKE ? OR receiver LIKE ?', "#{@user.id}", "#{@user.id}").destroy_all 
    Friend.where('id_user1 LIKE ? OR id_user2 LIKE ?', "#{@user.id}", "#{@user.id}").destroy_all



    @user.destroy
    #User.find(params[:id]).destroy
    redirect_to "/logout", :notice => "The user was successfully destroyed."

  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

	def require_login
	  unless logged_in?
		flash[:error] = "You must be logged in to access"
		redirect_to :root # halts request cycle
	  else
	    @numpetitions = @petitions = FriendshipRequest.where('receiver LIKE ?', "#{(User.find_by name: session[:user]).id}").count
	  end
	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :avatar, :admin)
    end
	
	def not_require_login
	    if logged_in?
		 # flash[:error] = !!session[:user]
		    redirect_to notes_url # halts request cycle
		end
	end

	def logged_in?
	    !!session[:user]
    end
end