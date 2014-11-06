class CategoriesController < ApplicationController
   #layout false
    skip_before_filter :verify_authenticity_token  
 before_action :confirm_logged_in, :except=> [:login,:attempt_login,:logout]

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
    cookies[:user_id]={:expires=>1.minute.from_now}
      cookies[:user_name]=authorized_user.username
      cookies[:hotel_id_for_login_user]=authorized_user.hotel_id
      flash[:notice]="You are now logged in."
      redirect_to(:action=>'index')
    else
     # session[:last_seen] = Time.now
       flash[:notice]="Invalid username/password combination."  
       redirect_to(:controller=>'homepage',:action=>'login')       
end
end

def logout
  cookies[:user_id]=nil
      cookies[:user_name]=nil
   flash[:notice]="Logged out"
   redirect_to(:controller=>'homepage',:action=>"login")
end

  # GET /categories
  # GET /categories.json
  def index
    @categories=Category.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    cookies[:categoryId]=params[:id]
    ss=params[:id]
    @menus=Menu.where(:category_id=>params[:id]).sorted 
     @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
      @categories=Category.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
  end

  # GET /categories/new
  

  # GET /categories/1/edit
  def edit
    @category=Category.find(params[:id])
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
  end

  # POST /categories
  # POST /categories.json
   def new
    @category = Category.new
  end
     def create
   #Instantiate a new object using form parameters
  @category=Category.new(category_params1)
  
   #Save the object
   if @category.save
     #If save succeeds,redirect to the index action
     @category.update( :hotel_id=>cookies[:hotel_id_for_login_user])
     flash[:notice]="Category Created Successfully"
     redirect_to(:controller=>'categories',:action=>'index')
   else
     #If save fails,redisplay the form so user can fix problems
   endrender('new')
   flash[:notice]="Category not Created "    
  end
  end
  
  
  
  def xxx
    logger.debug 
   #Instantiate a new object using form parameters
  @category=Category.new(:name=>params[:name])     
   #Save the object
   if @category.save
     #If save succeeds,redirect to the index action
     @category.update( :hotel_id=>session[:hotel_id_for_login_user])
     flash[:notice]="Category Created Successfully"
     redirect_to(:action=>'index')
   else
     #If save fails,redisplay the form so user can fix problems
   endrender('new')   
  end
  end

def update
   @category=Category.find(params[:id])
   # Update the object
   if @category.update_attributes(category_params)   
     #If update succeeds,redirect to the show action
     flash[:notice]="Category Updated Successfully"
     redirect_to(:action=>'index',:id=>@category.id)
   else
     #If update fails,redisplay the form so user can fix problems
   endrender('edit')
  end
end

def delete
    @category=Category.find(params[:id])
    
  end
  def destroy
    @category=Category.find(params[:id])
    #@menu=Menu.find(:category_id=>@category) 
    
    @category.destroy
     Menu.delete_all(:category_id=>@category)
    
    flash[:notice]="Category Destroyed Successfully"
        redirect_to(:action=>'index')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
    
     def showMenu
    @menu=Menu.where(:id=>params[:id])
  end
  
  def category_params1
      params.require(:category).permit(:name)
    end
    
   
    def hotelEdit
       @hotel2=Hotel.find(cookies[:hotel_id_for_login_user])
    end
    
    def createMenuItem
    @menu=Menu.new(menu_params)
    #Save the object
    #@menus=Menu.where(:category_id=>params[:id]).sorted
    if @menu.save
      #If save succeeds,redirect to the index action

      @menu.update( :hotel_id=>cookies[:hotel_id_for_login_user],:category_id=>cookies[:categoryId])

      flash[:notice]="Menu Item Created Successfully"
      redirect_to :controller=>'categories',:action => "show", :id => cookies[:categoryId]

    else
    #If save fails,redisplay the form so user can fix problems
      endrender('new')
    end
  end

end
