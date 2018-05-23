class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /collections
  # GET /collections.json
  def index
    #@collections = Collection.all
	show_collections
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
  end

  # GET /collections/new
  def new
	@user=User.find_by name: session[:user]
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
	@user=User.find_by name: session[:user]
  end
  
  def allcollections
  	@user=User.find_by name: session[:user]
	@collections = Collection.all
  end

  # POST /collections
  # POST /collections.json
 

  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to '/collections'}#@collection, notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
        @user=User.find_by name: session[:user]

        @collection_user = CollectionUser.new
        @collection_user.id_collection = @collection.id
        @collection_user.id_user = @user.id
        @collection_user.save
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }

      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to '/collections'}#@collection, notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # SHOW all collections from user
  def show_collections
    @user=User.find_by name: session[:user]
    @user_collections = CollectionUser.where('id_user LIKE ? ', "#{@user.id}")
    @collections = Array.new
    @user_collections.each do |collections|
      @collections.push(Collection.find(collections.id_collection))
    end

  end

  def share
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


  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @user=User.find_by name: session[:user]
    if CollectionUser.where('id_collection LIKE ?', "#{@collection.id}").count == 1
        CollectionNote.where('id_collection LIKE ?', "#{@collection.id}" ).destroy_all
        CollectionUser.where('id_collection LIKE ?', "#{@collection.id}" ).destroy_all

        @collection.destroy
    end

    CollectionUser.where('id_collection LIKE ? AND id_user LIKE ?', "#{@collection.id}" , "#{@user.id}" ).destroy_all
    redirect_to :collections
    #@collection.destroy
    #respond_to do |format|
     # format.html { redirect_to collections_url, notice: 'Collection was successfully destroyed.' }
     # 3format.json { head :no_content }
    #end
  end

  def show_notes_collection
    @notes_collection = Notes.where('id_collection LIKE ?', "#{@collection.id}")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
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
    def collection_params
      params.require(:collection).permit(:title)
    end
end
