class UserNotesController < ApplicationController
  before_action :set_user_note, only: [:show, :edit, :update, :destroy]

  # GET /user_notes
  # GET /user_notes.json
  def index
    @user_notes = UserNote.all
  end

  # GET /user_notes/1
  # GET /user_notes/1.json
  def show
  end

  # GET /user_notes/new
  def new
    @user_note = UserNote.new
  end

  # GET /user_notes/1/edit
  def edit
  end

  # POST /user_notes
  # POST /user_notes.json
  def create
    @user_note = UserNote.new(user_note_params)

    respond_to do |format|
      if @user_note.save
        format.html { redirect_to @user_note, notice: 'User note was successfully created.' }
        format.json { render :show, status: :created, location: @user_note }
      else
        format.html { render :new }
        format.json { render json: @user_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_notes/1
  # PATCH/PUT /user_notes/1.json
  def update
    respond_to do |format|
      if @user_note.update(user_note_params)
        format.html { redirect_to @user_note, notice: 'User note was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_note }
      else
        format.html { render :edit }
        format.json { render json: @user_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_notes/1
  # DELETE /user_notes/1.json
  def destroy
    @user_note.destroy
    respond_to do |format|
      format.html { redirect_to user_notes_url, notice: 'User note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_note
      @user_note = UserNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_note_params
      params.require(:user_note).permit(:id_user, :id_note)
    end
end
