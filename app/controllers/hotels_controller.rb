class HotelsController < ApplicationController
  layout :false
  skip_before_filter :verify_authenticity_token
   $search=@search
  def create
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%")
  # redirect_to(:action=>'create',:search=>params[:search])
  end
def show
  
end
  def index
    @cuisins=Cuisine.all
    if params[:search].present?
      @search=params[:search]
    end
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%")
    cookies[:searchValue]=params[:search]
    @hotelsLocation= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%").first
    #@hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%").includes(:offers)
    if params[:search].present? ? @hotels= Hotel.where('hotel_location LIKE ?',"%#{params[:search]}%").includes(:offers) : Hotel.includes(:offers,:cuisines)
      @hotel_name=params[:hotel_location]
      @search=params[:search]
    end
     if params[:cuisine_name].present?
      @hotelsAvailable=Cuisine.where(:cuisine_name=>params[:cuisine_name])
    end
  end

  def search
redirect_to(:action=>'index',:search=>params[:search],:cuisines=>@searchCuisine)
  end

  def edit

    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])

  #filename = params[:jpg].original_filename
  end

  def update

    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    # Update the object
    if @hotel.update_attributes(hotel_params)
      cookies[:trueValue]=params[:veg]
      #If update succeeds,redirect to the show action
      flash[:notice]="Hotel Updated Successfully"
      #redirect_to(:controller=>'categories',:action=>'index',:id=>@menu.id)
      redirect_to :controller=>'hotels',:action => "edit"
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
    params.require(:hotel).permit(:hotel_Name,:hotel_address,:hotel_location,:hotel_contactNo,:hotelImage,:min_order,:from_time,:to_time,:amOrPm1,:amOrPm,:veg,:non_veg)
  end

  def delete
    logger.debug
    @menu=Menu.find(params[:id])

  end

  def destroy

    @menu=Menu.find(params[:id1])
    #@menu=Menu.find(:category_id=>@category)
    @menu.destroy
    flash[:notice]="Menu Destroyed Successfully"
    redirect_to :controller=>'menus',:action => "new"
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