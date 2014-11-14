class OrdersController < ApplicationController
  layout :false
  skip_before_filter :verify_authenticity_token
  #before_action :set_order, only: [:show, :edit, :update, :destroy]
  # GET /orders
  # GET /orders.json
  before_action :confirm_logged_in_user, :except=> [:loginUser,:logout,:placeOrder,:new,:show,:index,:destroy,:create,:update]
  #before_action :set_category, only: [:show, :edit, :update, :destroy]
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
      redirect_to(:action=>'placeOrderStep2')
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
    @orders = Order.all
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    @categories=Category.where(:hotel_id=>session[:hotel_id_for_login_user1] )
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
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

  end

  # GET /orders/new
  def new
    @order1 = Order.order("created_at").last

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

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.save

      redirect_to(:action=>'new')

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
    @order = Order.new(order_params)
    @hotelUser=HotelUser.find(cookies[:user_id2])

    if @order.save

      @order.update_attributes(:phone=>@hotelUser.phoneNo,:name=> @hotelUser.userName,:hotel_user_id=>cookies[:user_id2],:email=>@hotelUser.email)

      addr=Array.new
      addr=["#{(@hotelUser.address1)}","#{(@hotelUser.address2)}","#{(@hotelUser.address3)}","#{(@hotelUser.address4)}","#{(@hotelUser.address5)}","#{(@hotelUser.address6)}","#{(@hotelUser.address7)}","#{(@hotelUser.address8)}","#{(@hotelUser.address9)}"]
      addr.each_with_index do |address,index|
        @value=index+1
        @newOrder=Order.find(@order.id)
        cookies[:aaaa]=@newOrder.address

       if address==''||nil
        if(@value)==2
          cookies[:aaaa1]='2'
          @hotelUser.update_attributes(:address2=>@newOrder.address)
         
         elsif(@value)==1
          cookies[:aaaa1]='1'
          @hotelUser.update_attributes(:address1=>@newOrder.address)
       
        elsif(@value)==3
          cookies[:aaaa1]='3'
          @hotelUser.update_attributes(:address3=>@newOrder.address)
       
        elsif(@value)==4
          cookies[:aaaa1]='4'
          @hotelUser.update_attributes(:address4=>@newOrder.address)
        
        elsif(@value)==5
          cookies[:aaaa1]='5'
          @hotelUser.update_attributes(:address5=>@newOrder.address)
       
        elsif(@value)==6
          cookies[:aaaa1]='6'
          @hotelUser.update_attributes(:address6=>@newOrder.address)
       
        elsif(@value)==7
          cookies[:aaaa1]='7'
          @hotelUser.update_attributes(:address7=>@newOrder.address)
      
        elsif(@value)==8
          cookies[:aaaa1]='8'
          @hotelUser.update_attributes(:address8=>@newOrder.address)
       
        else
          cookies[:aaaa1]='9'
          @hotelUser.update_attributes(:address9=>@newOrder.address)
     
        end
        break
        end
      end
      redirect_to(:action=>'show',:address1=>params[:address1])

    else
      render :placeOrderStep2

    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order1 = Order.order("created_at").last
    @order=Order.find(@order1.id)
    if @order.update_attributes(order_params)

      redirect_to(:action=>'show')
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

  def placeOrderStep2

    @hotelUser1=HotelUser.find(cookies[:user_id2])
    cookies[:phone]=@hotelUser1.phone
  end

end
