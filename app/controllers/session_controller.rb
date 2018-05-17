class SessionController < ApplicationController
  before_action :not_require_login, only: [:new, :create]

  def new
  end

  def create
  	@user=User.find_by name:	params[:username]
      if !@user
        #flash.now.alert="ERROR! Username #{params[:username]} was invalid"
        redirect_to '/login', :notice => "ERROR! Username #{params[:username]}"
        #render :new
      elsif @user.password == params[:password]
        session[:user]=@user.name
        redirect_to notes_url#, :notice => "Logged in!"
      else
        #flash.now.alert="ERROR! Password was invalid"
        redirect_to '/login',:notice => "ERROR! Username #{params[:username]}"
        #render :new
	end
  end

  def destroy
  	session[:user]=nil
	redirect_to :root, :notice => "Logged out!"
  end
  
  private
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
