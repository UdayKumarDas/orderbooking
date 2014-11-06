class HotelUsersController < ApplicationController
  
  layout false
  skip_before_filter :verify_authenticity_token
  def signup
    @hotelUser=Customer.new
    @city=City.all
  end

  def create

    @hotelUser = HotelUser.new(customer_params)

    if @hotelUser.save
      redirect_to(:controller=>'homepage')
    else
      redirect_to(:action=>'signup')
    end
  end
def createAddress
  @hotelUser=HotelUser.find(cookies[:user_id2])
  if @hotelUser.update_attributes(customer_params)
    redirect_to(:controller=>'orders',:action=>'show')
  else
    render :placeOrderStep2
  end
end
  def customer_params
    params.require(:hotelUser).permit(:userName, :password, :phoneNo, :city, :email,:address1,:address2)
  end
  def index
    
  end
end
