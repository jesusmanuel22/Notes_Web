class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /friendship_requests
  # GET /friendship_requests.json
  def index
    #@petitions = FriendshipRequest.all
	getFriendsRequest
  end

  # GET /friendship_requests/1
  # GET /friendship_requests/1.json
  def show
  end

  # GET /friendship_requests/new
  def new
    @friendship_request = FriendshipRequest.new
  end

  # GET /friendship_requests/1/edit
  def edit
  end

  # POST /friendship_requests
  # POST /friendship_requests.json
  def create
    @friendship_request = FriendshipRequest.new(friendship_request_params)

    respond_to do |format|
      if @friendship_request.save
        format.html { redirect_to @friendship_request}#, notice: 'Friendship request was successfully created.' }
        format.json { render :show, status: :created, location: @friendship_request }
      else
        format.html { render :new }
        format.json { render json: @friendship_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendship_requests/1
  # PATCH/PUT /friendship_requests/1.json
  def update
    respond_to do |format|
      if @friendship_request.update(friendship_request_params)
        format.html { redirect_to @friendship_request, notice: 'Friendship request was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship_request }
      else
        format.html { render :edit }
        format.json { render json: @friendship_request.errors, status: :unprocessable_entity }
      end
    end
  end

  
  #Aceptar peticiones amistad
  def acceptFriendshipRequest
    @user = (User.find_by name: session[:user])
	@request = (FriendshipRequest.find_by id: params[:name])
    @friendship = Friend.new
    @friendship.id_user1 = @request.sender #params[:id]#@friendshipreqs.id
    @friendship.id_user2 = @user.id
    @friendship.save

    FriendshipRequest.where('sender LIKE ? AND receiver LIKE ? ',"#{@request.sender}","#{@user.id}").destroy_all
	
    redirect_to '/friendship_requests'#:back
  end
  
  
  # DELETE /friendship_requests/1
  # DELETE /friendship_requests/1.json
  def destroy
    @friendship_request.destroy
    respond_to do |format|
      format.html { redirect_to friendship_requests_url}#, notice: 'Friendship request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def getFriendsRequest
    @user=User.find_by name: session[:user]
    @petitions = FriendshipRequest.where('receiver LIKE ?', "#{@user.id}")
  end
  
  def numberFriendsRequest
	getFriendsRequest.count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship_request
      @friendship_request = FriendshipRequest.find(params[:id])
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
    def friendship_request_params
      params.require(:friendship_request).permit(:sender, :receiver, :text, :expiration_date)
    end
end
