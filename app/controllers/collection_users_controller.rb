class CollectionUsersController < ApplicationController
  before_action :set_collection_user, only: [:show, :edit, :update, :destroy]

  # GET /collection_users
  # GET /collection_users.json
  def index
    @collection_users = CollectionUser.all
  end

  # GET /collection_users/1
  # GET /collection_users/1.json
  def show
  end

  # GET /collection_users/new
  def new
    @collection_user = CollectionUser.new
  end

  # GET /collection_users/1/edit
  def edit
  end

  # POST /collection_users
  # POST /collection_users.json
  def create
    @collection_user = CollectionUser.new(collection_user_params)

    respond_to do |format|
      if @collection_user.save
        format.html { redirect_to '/collections'}#@collection_user, notice: 'Collection user was successfully created.' }
        format.json { render :show, status: :created, location: @collection_user }
      else
        format.html { render :new }
        format.json { render json: @collection_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collection_users/1
  # PATCH/PUT /collection_users/1.json
  def update
    respond_to do |format|
      if @collection_user.update(collection_user_params)
        format.html { redirect_to @collection_user, notice: 'Collection user was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection_user }
      else
        format.html { render :edit }
        format.json { render json: @collection_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collection_users/1
  # DELETE /collection_users/1.json
  def destroy
    @collection_user.destroy
    respond_to do |format|
      format.html { redirect_to collection_users_url, notice: 'Collection user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection_user
      @collection_user = CollectionUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_user_params
      params.require(:collection_user).permit(:id_collection, :id_user)
    end
end
