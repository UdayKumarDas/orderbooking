class AdminController < ApplicationController
  #skip_before_filter :verify_authenticity_token  
  layout false
   #before_action :confirm_logged_in, :except=> [:login,:attempt_login,:logout]
  def index
    @locations=Location.all
  end
  def AddLocation
    #@location=Location.new
  end
def create1
  @location=Location.new(location_params)
 if @location.save
   redirect_to(:action =>'index')   
 else
   render('new')
 end
end
  def EditLocation
  end
  private
  def location_params
    params.require(:location).permit(:Locationname)
  end
  
   def category_params1
      params.require(:category).permit(:name)
    end
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
  
  
  
end
  #before_action :set_category, only: [:show, :edit, :update, :destroy]
 
