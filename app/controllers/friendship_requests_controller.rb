class FriendshipRequestsController < ApplicationController
  before_action :set_friendship_request, only: [:show, :edit, :update, :destroy]

  # GET /friendship_requests
  # GET /friendship_requests.json
  def index
    @friendship_requests = FriendshipRequest.all
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
        format.html { redirect_to @friendship_request, notice: 'Friendship request was successfully created.' }
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

  # DELETE /friendship_requests/1
  # DELETE /friendship_requests/1.json
  def destroy
    @friendship_request.destroy
    respond_to do |format|
      format.html { redirect_to friendship_requests_url, notice: 'Friendship request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  def numberFriendsRequest
    
    @user=User.find_by name: session[:user]
    @petitions = FriendshipRequest.where('receiver LIKE ?', "#{user.id}").count

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship_request
      @friendship_request = FriendshipRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_request_params
      params.require(:friendship_request).permit(:sender, :receiver, :text, :expiration_date)
    end
end
