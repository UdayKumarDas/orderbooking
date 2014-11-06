class HomepageController < ApplicationController
  
  layout :false
before_action :confirm_logged_in, :except=> [:login,:attempt_login,:logout,:index]
  #before_action :set_category, only: [:show, :edit, :update, :destroy]
 

  def index
  end
  
  def searchHotel
    #@location= @location.where(:name => params[:search])
    #@locations= Location.where('Locationname LIKE ?',"%#{params[:search]}%")
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%")
  end
  
  # before_action :confirm_logged_in, :except=> [:login,:attempt_login,:logout]

  #before_action :set_category, only: [:show, :edit, :update, :destroy]
 def attempt_login
    if params[:username].present? && params[:password].present?
        found_user = User.where(:username => params[:username]).first #this will return the first record
  if found_user
    authorized_user= found_user.authenticate(params[:password])
      end
    end
    if authorized_user
     # reset_session if session[:last_seen] < 1.minutes.ago
    #session[:last_seen] = Time.now
      cookies[:user_id]=authorized_user.id
    
      cookies[:user_name]=authorized_user.username
      cookies[:hotel_id_for_login_user]=authorized_user.hotel_id
      flash[:notice]="You are now logged in."
      redirect_to(:action=>'index')
    else
     # session[:last_seen] = Time.now
       flash[:notice]="Invalid username/password combination."  
       redirect_to(:action=>'login')       
end
end
end
