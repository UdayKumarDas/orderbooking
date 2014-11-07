class UsersController < ApplicationController
  layout false
 
 before_action :confirm_logged_in, :except=> [:login,:attempt_login,:logout,:createUserForHotel,:params_createUserForHotel]
  def index
    render :controller=>'categories',:action => 'index'
     @users=User.all      
     @hotels=Hotel.where(:id=>1 )
     @categories=Category.where(:hotel_id=>session[:hotel_id_for_login_user] )
     
  end

  def login
    @users=User.all
  end
 
  def attempt_login
    if params[:username].present? && params[:password].present?
        found_user = User.where(:username => params[:username]).first #this will return the first record
  if found_user
    authorized_user= found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      session[:user_id]=authorized_user.id
      session[:user_name]=authorized_user.username
      session[:hotel_id_for_login_user]=authorized_user.hotel_id
      flash[:notice]="You are now logged in."
      redirect_to(:action=>'index')
    else
       flash[:notice]="Invalid username/password combination."
       redirect_to(:controller=>'categories')       
end
end

def logout
  session[:user_id]=nil
      session[:user_name]=nil
   flash[:notice]="Logged out"
   redirect_to(:action=>"login")
end
def show
     @categories=Category.find(params[:id])
  end

  def new
    @category=Category.new
  end

  def edit
    @category=Category.find(params[:id])
  end

  def delete
    @subject=Subject.find(params[:id])
  end
  def destroy
    @subject=Subject.find(params[:id])
    @subject.destroy
    flash[:notice]="Subject Destroyed Successfully"
        redirect_to(:action=>'index')
  end
  def create
   #Instantiate a new object using form parameters
   @category=Category.new(category_params) 
   #Save the object
   if @category.save
     #If save succeeds,redirect to the index action
     flash[:notice]="Category Created Successfully"
     redirect_to(:action=>'index')
   else
     #If save fails,redisplay the form so user can fix problems
   endrender('new')
  end
  end
  
  def update
   # Find an existing object using form parameters
   @subject=Subject.find(params[:id])
   # Update the object
   if @subject.update_attributes(subject_params)   
     #If update succeeds,redirect to the show action
     flash[:notice]="Subject Updated Successfully"
     redirect_to(:action=>'show',:id=>@subject.id)
   else
     #If update fails,redisplay the form so user can fix problems
   endrender('edit')
  end
  end
  def category_params
    #param[:x]=session[:hotel_id_for_login_user]
    params.require(:category).permit(:name,{:hotel_id=>[session[:hotel_id_for_login_user]]})
  end
  def showMenu
  @menus=Menu.where(params[:hotel_id] ).sorted  
end

end

