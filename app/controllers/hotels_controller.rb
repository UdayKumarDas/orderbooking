class HotelsController < ApplicationController
  layout :false
  skip_before_filter :verify_authenticity_token
  def create
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%")

  end

  def index
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%")
    cookies[:searchValue]=params[:search]
     @hotelsLocation= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%").first
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%").includes(:offers)
    if params[:search].present? ? @hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%").includes(:offers) : Hotel.includes(:offers)
      @hotel_name=params[:hotel_location]
    end
    if params[:search].blank?
      flash[:hh]="Sorry, we do not have any hotels delivering to this location."
      redirect_to(:controller=>'homepage')
    end
    
    
    
  end

  def edit

    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])

  #filename = params[:jpg].original_filename
  end

  def update

    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    # Update the object
    if @hotel.update_attributes(hotel_params)
      #If update succeeds,redirect to the show action
      flash[:notice]="Hotel Updated Successfully"
      #redirect_to(:controller=>'categories',:action=>'index',:id=>@menu.id)
      redirect_to :controller=>'categories',:action => "index"
    else
    #If update fails,redisplay the form so user can fix problems
      endrender('edit')
    end
  end

  def edit1

    @menu=Menu.find(params[:id])

  #filename = params[:jpg].original_filename
  end

  def nnn

    @menu=Menu.find(params[:id])
    # Update the object
    if @menu.update_attributes(menu_params)
      #If update succeeds,redirect to the show action
      flash[:notice]="Menu Updated Successfully"
      #redirect_to(:controller=>'categories',:action=>'index',:id=>@menu.id)
      redirect_to :controller=>'categories',:action => "show", :id => cookies[:categoryId]
    else
    #If update fails,redisplay the form so user can fix problems
      endrender('edit')
    end

  end

  def hotel_params
    params.require(:hotel).permit(:hotel_Name,:hotel_address,:hotel_location,:hotel_contactNo,:hotelImage,:min_order)
  end

  def delete
    logger.debug
    @menu=Menu.find(params[:id])

  end

  def destroy

    @menu=Menu.find(params[:id])
    #@menu=Menu.find(:category_id=>@category)
    @menu.destroy
    flash[:notice]="Menu Destroyed Successfully"
    redirect_to :controller=>'menus',:action => "new", :id => cookies[:categoryId]
  end

  def loginUser
    if params[:email].present? && params[:password].present?
      found_user = HotelUser.where(:email => params[:email]).first #this will return the first record

      if found_user
        authorized_user1= found_user.authenticate(params[:password])
      end
    end
    if authorized_user1
      # reset_session if session[:last_seen] < 1.minutes.ago
      #session[:last_seen] = Time.now
      cookies[:user_id2]=authorized_user1.id

      cookies[:user_name2]=authorized_user1.userName
      @hotelUser=HotelUser.find( cookies[:user_id2])
      cookies[:uName]=@hotelUser.userName
      #session[:hotel_id_for_login_user]=authorized_user.hotel_id
      flash[:notice]="You are now logged in."
      cookies[:searchValue]=params[:search]
     redirect_to(:back)
    else
    # session[:last_seen] = Time.now
      flash[:notice]="Invalid username/password combination."
      redirect_to(:back)
    end
  end
  
  
  

  def createnewhotel
    @hotels=Hotel.all
  end

  def createHotel
    @hotel=Hotel.new(params_createHotel)
    if @hotel.save
      flash[:notice]="New Hotel is created successfully"
      redirect_to(:action=>'createnewhotel')
    else
      flash[:notice]="Hotel not created"
      redirect_to(:action=>'createnewhotel')
    end
  end

  def params_createHotel
    params.require(:hotel).permit(:hotel_Name,:hotel_location)
  end

  def createUserForHotel
    @user=User.new(params_createUserForHotel)
    if @user.save
      flash[:notice]="New user is created for the hotel"
      redirect_to(:controller=>'hotels',:action=>"createnewhotel")
    else
      flash[:notice]="New user not created "
      redirect_to(:controller=>'hotels',:action=>"createnewhotel")
    end
  end

def createUser
  
end
  def params_createUserForHotel
    
    params.require(:user).permit(:username,:password,:email,:hotel_id)

  end

end