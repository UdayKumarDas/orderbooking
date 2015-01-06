class HotelUsersController < ApplicationController
  
  layout false
  skip_before_filter :verify_authenticity_token
  def signup
    #@hotelUser=Customer.new
    @city=City.all
  end

  def create

    @hotelUser = HotelUser.new(customer_params)

    if @hotelUser.save
      redirect_to(:controller=>'homepage')
      flash[:notice]="New user successfully created"
    else      
      redirect_to(:action=>'signup')
      flash[:notice]="New user not created"
    end
  end
def createaddress
  @hotelUser=HotelUser.find(cookies[:user_id2])
  if @hotelUser.update_attributes(customer_params)
    redirect_to(:controller=>'orders',:action=>'show',:addr=>params[:addr])
  else
    render :placeOrderStep2
  end
end

 def editHotelUser
      @hotel_User=HotelUser.find(cookies[:user_id2])
    @hotel_User.update_attributes(customer_params)  
   redirect_to(:controller=>'orders',:action=>'editDashboard')
   
  end
  def customer_params
    params.require(:hotelUser).permit(:userName, :password, :phoneNo, :city, :email,:address1,:address2,:address3,:address4,:address5,:address6,:address7,:address8,:address9)
  end
  def index
    
  end
  
  def deleteAddress
   @hotelUser= HotelUser.find(params[:user])
   if params[:address]=='address2'
    @hotelUser.update_attributes(:address2=>'')
  end
    if params[:address]=='address3'
    @hotelUser.update_attributes(:address3=>'')
  end
   if params[:address]=='address4'
    @hotelUser.update_attributes(:address4=>'')
  end
   if params[:address]=='address5'
    @hotelUser.update_attributes(:address5=>'')
  end
   if params[:address]=='address6'
    @hotelUser.update_attributes(:address6=>'')
  end
   if params[:address]=='address7'
    @hotelUser.update_attributes(:address7=>'')
  end
   if params[:address]=='address8'
    @hotelUser.update_attributes(:address8=>'')
  end
   if params[:address]=='address9'
    @hotelUser.update_attributes(:address9=>'')
  end
  redirect_to(:controller=>'orders',:action=>'editDashboard',:userAction=>params[:userAction])
  end

  def updateAddress
    @hotel_User=HotelUser.find(params[:hotelUserId])
       @hotel_User.update_attributes(customer_params)
       redirect_to(:controller=>'orders',:action=>'editDashboard',:userAction=>params[:userAction])
  end
end
