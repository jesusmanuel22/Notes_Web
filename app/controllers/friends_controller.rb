class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  
  # GET /friends
  # GET /friends.json
  def index
    #@friends = Friend.all
	getFriends
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end
  
  def allfriends
    @allFriends = Friend.all
    @friend1 = Array.new
    @friend2 = Array.new
    @allfriends.each do |friends_rel|
      @friend1.push(User.find(friends_rel.id_user1))
      @friend2.push(User.find(friends_rel.id_user2))
    end
  end
  #Get User Friends
  def getFriends
    @user=User.find_by name: session[:user]
    @friends = Friend.where('id_user1 LIKE ? OR id_user2 LIKE ?',"#{@user.id}","#{@user.id}");
    @usersFriends = Array.new
    @friends.each do |friend|
      if friend.id_user1 == @user.id
        @usersFriends.push(User.find(friend.id_user2))
      else
        @usersFriends.push(User.find(friend.id_user1))
      end
    end
  end

  # GET /friends/1/edit
  def edit
  end

  #DELETE FRIENDS
  def destroyFriend
      friendDestroy=params[:friendDestroy]
      @session = User.find_by name: session[:user]
      @friendship = Friend.where('id_user1 LIKE ? AND id_user2 LIKE ?', "#{@session.id}","#{friendDestroy}")
      @friendship.destroy_all
      @friendship = Friend.where('id_user2 LIKE ? AND id_user1 LIKE ?', "#{@session.id}","#{friendDestroy}")
      @friendship.destroy_all
      redirect_to friends_url
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

	def require_login
	  unless logged_in?
		flash[:error] = "You must be logged in to access"
		redirect_to :root # halts request cycle
	  else
	    @numpetitions = @petitions = FriendshipRequest.where('receiver LIKE ?', "#{(User.find_by name: session[:user]).id}").count
	  end
	end

	def logged_in?
		!!session[:user]
	end
	
    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_params
      params.require(:friend).permit(:id_user1, :id_user2)
    end
end
