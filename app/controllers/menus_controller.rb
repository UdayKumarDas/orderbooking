class MenusController < ApplicationController
  layout :false
  skip_before_filter :verify_authenticity_token
  before_action :find_hotel
  #before_action :confirm_logged_in
  #A_CONST=@category.id
  def index
    if cookies[:hotelIdCheck]!=params[:hotel_id]
      cookies[:xxx]=nil
      cookies[:hotelIdCheck]=params[:hotel_id]
    end
    @offersFormenus=Offer.where(:hotel_id=>params[:hotel_id])
    @offers= Offer.where(:offer_type =>'discountOnAmount').order( 'amountforDiscount DESC' )
    @offers1= Offer.where(:offer_type =>'discountOnAmount').order( 'amountforDiscount DESC' )
    @offers2= Offer.where(:disType_get =>'%').order( 'menuName_get ASC' )
    @offers3= Offer.where(:disType_get =>'Rs.').order( 'menuName_get ASC' )

    @line_item_for_offers=LineItem.where(:cart_id=> current_cart)
    @totalQuantity=LineItem.where(:cart_id=> current_cart).sum(:quantity)
    # @first_category=Category.find(:first, :conditions => [ :hotel_id=>params[:hotel_id]])
    #select  id from categories where hotel_id=4 limit 1
    #@first_category=Category.where(:hotel_id=>params[:hotel_id]).limit(1)
    #@first_category=Category.find_by_sql(%q{select  id from categories where hotel_id=4 limit 1})
    @hotel = Hotel.find(params[:hotel_id])
    cookies[:hotelId]=params[:hotel_id]
    @category = Category.where(:hotel_id => params[:hotel_id]).first
    if @category.present?
      @menus2=Menu.where(:category_id=> @category.id).sorted

    else
      flash[:message]="Sorry, we do not have any menus present in #{params[:hotel_Name]}."
      redirect_to(:back)
    end

    @categories=Category.where(:hotel_id=>params[:hotel_id])
    #@categoriesxx=Category.where(:hotel_id=>params[:hotel_id]).first
    @cart = current_cart

    if params[:name]==params[:name]
      #@categories=Category.where(:hotel_id=>params[:hotel_id])
      @menus=Menu.where(:category_id=> params[:id]).sorted
      @categoryName=params[:name]
    @@menus=@menus
    #@menus=@hotel.menus.sorted
    #@link_name=params[:name]
    else

    end

  end

  def logout

    cookies[:uName]=nil
    redirect_to(:controller=>'homepage',:action=>'index')
  end

  def addItem

    @cart = current_cart
    menu = Menu.find(params[:menu_id])
    @line_item = @cart.add_menu(menu.id)
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(:back) }

        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end
  #@menus=@hotel.menus.sorted

  def showMenu
    @menus=Menu.find(params[:id])
  end

  def show
    @menu=Menu.find(params[:id])
    session[:categoryId]=params[:id]
    @menus=Menu.where(:category_id=>params[:id]).sorted
  end

  def new
    @menu=Menu.new
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    @categories=Category.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
    #@menus1=Menu.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
    if params[:category].present?
      @catId=params[:category]
    end
    @menus2  = params[:category].blank? ? Menu.where(:hotel_id=>cookies[:hotel_id_for_login_user]) : Menu.where(category_id: @catId)

  end

  def create
    @menu=Menu.new(menu_params)
    #Save the object
    #@menus=Menu.where(:category_id=>params[:id]).sorted
    if @menu.save
      #If save succeeds,redirect to the index action

      @menu.update( :hotel_id=>cookies[:hotel_id_for_login_user])

      flash[:notice]="Menu Item Created Successfully"
      @menus2  = params[:category].blank? ? Menu.all : Menu.where(category_id: params[:category])
      redirect_to :controller=>'menus',:action => "new", :id => cookies[:categoryId]

    else
    #If save fails,redisplay the form so user can fix problems
      endrender('new')
    end
  end

  def find_hotel
    if params[:hotel_id]
      @hotel=Hotel.find(params[:hotel_id])
    end
  end

  def menu_params
    params.require(:menu).permit(:menu_item_name,:price,:item_type,:image,:category_id)
  end

  def edit1
    @menu=Menu.find(params[:id])
  #filename = params[:jpg].original_filename
  end

  def update1
    @menu=Menu.find(params[:id])
    # Update the object
    if @menu.update_attributes(menu_params)
      #If update succeeds,redirect to the show action
      flash[:notice]="Menu Updated Successfully"
    #redirect_to(:controller=>'categories',:action=>'index',:id=>@menu.id)
    #redirect_to(:back)
    else
    #If update fails,redisplay the form so user can fix problems
      endrender('edit')
    end
  end

  def edit1
    @menu=Menu.find(params[:id])
  #filename = params[:jpg].original_filename
  end

  def update1
    @menu=Menu.find(params[:id])
    # Update the object
    if @menu.update_attributes(menu_params)
      #If update succeeds,redirect to the show action
      flash[:notice]="Menu Updated Successfully"
    #redirect_to(:controller=>'categories',:action=>'index',:id=>@menu.id)
    #redirect_to(:back)
    else
    #If update fails,redisplay the form so user can fix problems
      endrender('edit')
    end
  end

  def edit

    @menu=Menu.find(params[:id])

  #filename = params[:jpg].original_filename
  end

  def update

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

  def delete
    logger.debug
    @menu=Menu.find(params[:id])

  end

  def destroy
    logger.debug
    @menu=Menu.find(params[:id])
    @menu=Menu.find(:category_id=>@category)
    @menu.destroy
    flash[:notice]="Menu Destroyed Successfully"
  end

  def menuList
    session[:categoryId]=params[:id]
    @menus=Menu.where(:category_id=>params[:id]).sorted
    session[:return_to] ||= request.referer
  end

  def search
    @categories=Category.where(:hotel_id=>cookies[:hotel_id_for_login_user])
    @menus2  = params[:category].blank? ? Menu.all : Menu.where(category_id: params[:category])
  #redirect_to :controller=>'menus',:action => "new"
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
      redirect_to(:action=>'index',:hotel_id => cookies[:hotelId])
    else
    # session[:last_seen] = Time.now
      flash[:notice]="Invalid username/password combination."
      redirect_to(:action=>'index',:hotel_id => cookies[:hotelId])
    end
  end
end
