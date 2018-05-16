class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @user=User.find_by name: session[:user]
    @notes=Array.new
    #@notes = Note.where('note.id LIKE "user_notes".id_note AND "user_notes".id_user == ?', "#{@user.id}")
    sql = "SELECT 'notes'.* FROM 'notes', 'user_notes' WHERE 'notes'.'id' == 'user_notes'.id_note AND 'user_notes'.id_user == #{@user.id}"
    result = ActiveRecord::Base.connection.execute(sql)
    result.each do |row|
     @note = Note.new
     @note.id = row[0]
     @note.title = row[1]
     @note.text = row[2]
     @note.image = row[3]
     @notes.push(@note)
    end
    #@result.each do |notes|
     #@notes=Note.select("'notes'.* FROM 'notes', 'user_notes' WHERE 'notes'.id == 'user_notes'.id_note AND 'user_notes'.id_user == #{@user.id}")
    #end
    #@notes = Note.joins(:user_note).where("id_user == #{@user.id}").uniq
	#@user=User.find_by name: session[:user]
	#@notes = Note.where('id_user LIKE ?', "#{@user.id}")

  end

  def allnotes
	@notes = Note.all
  end
  
  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
        @user_note = UserNote.new
        @user=User.find_by name: session[:user]
        @user_note.id_user = @user.id
        @user_note.id_note = @note.id
        @user_note.save
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :text, :image)
    end
end
