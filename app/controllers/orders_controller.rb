class OrdersController < ApplicationController
  layout :false
  skip_before_filter :verify_authenticity_token
 
  before_action :confirm_logged_in_user, :except=> [:loginUser,:logout,:placeOrder,:new,:show,:index,:search,
    :destroy,:create,:update,:deliveryPath,:delivery,:order_params,:searchData,:edit]
  before_action :confirm_logged_in, :only=> [:index]
  helper_method :sort_column,:sort_direction  
  
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
      #session[:hotel_id_for_login_user]=authorized_user.hotel_id
       
      flash[:notice]="You are now logged in."
      redirect_to(:action=>'placeOrderStep2',:UserId=>cookies[:user_id2])
    else
    # session[:last_seen] = Time.now
      flash[:notice]="Invalid username/password combination."
      redirect_to(:action=>'placeOrder')
    end
  end

  def logout
    cookies[:user_id2]=nil
    cookies[:user_name2]=nil
    flash[:notice]="Logged out"
    redirect_to(:controller=>'orders',:action=>"placeOrder")
  end

  def index
    @search=Order.search(params[:search])
    @orders=(Order.where(:hotel_user_id=>cookies[:hotel_id_for_login_user])).search(params[:search]).order(sort_column.to_s  + " " + sort_direction.to_s).paginate(:per_page=>5,:page=>params[:page])
 
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    @categories=Category.where(:hotel_id=>session[:hotel_id_for_login_user1] )
    if params[:created_at].present?
      @date=Time.parse(params[:created_at].to_s).utc
    @allId=Array.new
    @filterDate= params[:created_at]
    @d=Date.new(@filterDate['(1i)'].to_i, @filterDate['(2i)'].to_i, @filterDate['(3i)'].to_i)
    @createdOrders=(Order.where(:hotel_user_id=>cookies[:hotel_id_for_login_user])).order(sort_column.to_s  + " " + sort_direction.to_s).paginate(:per_page=>5,:page=>params[:page])
    @createdOrders.each do |order|
    
    ord=order.created_at.strftime("%Y-%m-%d")
    order.id
    if ord.to_s==@d.to_s 
       @allId << order.id
      end
      end
      end
      end
   
  def search
     redirect_to(:action=>'index',:created_at=>params[:created_at])
 end
    #@orders=Order.where('created_at LIKE ?','%#{d.to_s}%')
 def searchData
  
   redirect_to(:action=>'index',:created_at=>params[:created_at],:search=>params[:search])
 end

  
def delivery 
  @hotel=Hotel.find(cookies[:hotelId])    
  @order1 = Order.where(:orderId=>params[:orderId])
 @order = Order.find(@order1)
 
 @time=Time.now.strftime("%I:%M %p")
 duration = @hotel.deliverytime.hour * 60 * 60 + @hotel.deliverytime.min * 60 + @hotel.deliverytime.sec
      @delivery_time=(Time.now + duration).strftime("%I:%M %p")
 if @order
   @order.update_attributes(:pay_type=>params[:pay_type],:order_time=>@time,:hotel_user_id=>cookies[:hotelId],
   :order_delivery_time=>@delivery_time,:total_amount=>cookies[:total_price].present? ? cookies[:total_price] : cookies[:pricexx] ,
   :discount=>cookies[:discount_price],:final_total=>cookies[:pricexx],:cartId=>current_cart.id)
 end
  @hotel=Hotel.find(cookies[:hotelId])
  @cart=current_cart
   OrderMailer.welcome_email(@order,@cart,@hotel,cookies[:discount_price],cookies[:total_price],cookies[:pricexx]).deliver
   # put your own credentials here 
account_sid = 'ACc30a8aed0136f83c38b0caf3b45800a2' 
auth_token = '036040097e67f71d755a4771f3488834' 
 
# set up a client to talk to the Twilio REST API 
@client = Twilio::REST::Client.new account_sid, auth_token 
 
@client.account.messages.create({
  :from => '+15156195206', 
  #:to =>'+91' + @order.phone.to_s, 
  :to =>'+919439196255', 

  :body => 'Your order'+ ' ' + @order.orderId +  ' ' + 'from'+ ' ' + @hotel.hotel_Name + ' ' + 'is successfull.' + ' '+ 'Your order will reach you by' +' '+ @order.order_delivery_time.to_s,  
})

end

def deliveryPath 
  
  if params[:pay_type]=="COD"
    redirect_to(:action=>'delivery',:orderId=>params[:orderId],:pay_type=>params[:pay_type])
  end
end


  def show
    @orderTime=Hotel.find(cookies[:hotelId])
    if cookies[:user_id2].present?             
     @loginUser=HotelUser.find(cookies[:user_id2])     
      @order = Order.new
    @orderNo=String.random_alphanumeric(size=10).upcase
    @order.save
    @order.update_attributes(:orderId=>@orderNo)     
     @orderForLoginuser=Order.where(:orderId=>@orderNo).first
    @orderForLoginuser.update_attributes(:name=>@loginUser.userName,:email=>@loginUser.email,:phone=>@loginUser.phoneNo,:hotel_user_id=>cookies[:hotelId])
    else
      @order=Order.find(params[:UserId])
      @orderNo=String.random_alphanumeric(size=10).upcase
       @order.update_attributes(:orderId=>@orderNo)   
    end
    if params[:address1].present?
      @orderForLoginuser.update_attributes(:address=> params[:address1])
    end
    
    @cart = current_cart
    @line_item=LineItem.where(:cart_id=>@cart.id).all
    #@menus=Menu.where(:id=>@line_item.menu_id).all
    @hotel = Hotel.find(cookies[:hotelId])
    @offers=Offer.where(:hotel_id=>cookies[:hotelId])
    @buy1get1=Offer.where(:offer_type=>'buy1get1')
    @buy2get1=Offer.where(:offer_type=>'buy2get1')
    @buy3get1=Offer.where(:offer_type=>'buy3get1')
    @buy4get1=Offer.where(:offer_type=>'buy4get1')
    @buy5get1=Offer.where(:offer_type=>'buy5get1')



 if params[:address2].present?
      @orderForLoginuser.update_attributes(:address=> params[:address2])
        
    @hotelUser=HotelUser.find(cookies[:user_id2])

    if @orderForLoginuser

      #@order.update_attributes(:phone=>@hotelUser.phoneNo,:name=> @hotelUser.userName,:hotel_user_id=>cookies[:user_id2],:email=>@hotelUser.email)

      addr=Array.new
      addr=["#{(@hotelUser.address1)}","#{(@hotelUser.address2)}","#{(@hotelUser.address3)}","#{(@hotelUser.address4)}","#{(@hotelUser.address5)}","#{(@hotelUser.address6)}","#{(@hotelUser.address7)}","#{(@hotelUser.address8)}","#{(@hotelUser.address9)}"]
      addr.each_with_index do |address,index|
        @value=index+1
        @newOrder=Order.find(@orderForLoginuser.id)
        cookies[:aaaa]=@newOrder.address

       if address==''||nil
        if(@value)==2
          cookies[:aaaa1]='2'
          @hotelUser.update_attributes(:address2=>params[:address2])
         
         elsif(@value)==1
          cookies[:aaaa1]='1'
          @hotelUser.update_attributes(:address1=>params[:address2])
       
        elsif(@value)==3
          cookies[:aaaa1]='3'
          @hotelUser.update_attributes(:address3=>params[:address2])
       
        elsif(@value)==4
          cookies[:aaaa1]='4'
          @hotelUser.update_attributes(:address4=>params[:address2])
        
        elsif(@value)==5
          cookies[:aaaa1]='5'
          @hotelUser.update_attributes(:address5=>params[:address2])
       
        elsif(@value)==6
          cookies[:aaaa1]='6'
          @hotelUser.update_attributes(:address6=>params[:address2])
       
        elsif(@value)==7
          cookies[:aaaa1]='7'
          @hotelUser.update_attributes(:address7=>params[:address2])
      
        elsif(@value)==8
          cookies[:aaaa1]='8'
          @hotelUser.update_attributes(:address8=>params[:address2])
       
        else
          cookies[:aaaa1]='9'
          @hotelUser.update_attributes(:address9=>params[:address2])
     
        end
        break
        end
      end   end
    

  end
  
  
  
  end

  # GET /orders/new
  def new
    @hotel=Hotel.find(cookies[:hotelId])
    @hash = Gmaps4rails.build_markers(@hotel) do |hotel, marker|      
    marker.lat hotel.latitude
    marker.lng hotel.longitude
  
   
    marker.infowindow hotel.hotel_Name
end
    
    if current_cart.line_items.empty?
      redirect_to menu_url, :notice => "Your cart is empty"
    return
    end
    @order = Order.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @order }
    end

  end

  # GET /orders/1/edit
  def edit
  end
  
def String.random_alphanumeric(size=10)
s = ""
size.times { s << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
s
end
  
  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
 
    if @order.save

      redirect_to(:action=>'new',:orderId=>@order.id)

    else
      render :new

    end
  end

  def orderCreate
    @order=Order.find(@order1.id)
    if @order.save
      @order.update(:address=>params[:address])
      redirect_to(:action=>'new')

    else
      render :placeOrder

    end
  end

  def orderCreate1
   
    
    #@order = Order.where(:orderId=>params[:orderId]).first
    @hotelUser=HotelUser.find(cookies[:user_id2])

    if @hotelUser

     
      redirect_to(:action=>'show',:orderId=>params[:orderId],:address2=>params[:address1])

    else
      render :placeOrderStep2

    end
  end
  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    
    @order = Order.find(params[:orderId])
   
 
    if @order.update_attributes(order_params)

      redirect_to(:action=>'show',:UserId=>params[:orderId])
    else
      redirect_to(:action=>'new')
    end

  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order=Order.find(params[:id])
    @order.destroy
    flash[:error]=""
    redirect_to(:controller=>'orders',:action=>'index')
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type,:phone)
  end

  def placeOrder

    @order = Order.new

  end

def userDashboard

end
  def placeOrderStep2
 
params[:orderId]=@orderNo
    @hotelUser1=HotelUser.find(cookies[:user_id2])
    cookies[:phone]=@hotelUser1.phone
  end
  
private
def sort_column
    Order.column_names.include?(params[:sort]) ? params[:sort] : "name"
end

def sort_direction
  %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
end

def editDashboard

end   
  def params_hotelUser
    params.require(:hotelUser).permit(:userName, :password, :phoneNo, :city, :email,:address1)
  end
end
