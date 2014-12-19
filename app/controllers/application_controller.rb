class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #reset_session
  private

  def confirm_logged_in
    unless cookies[:user_id].present?
      flash[:notice]="Please log in"
      redirect_to(:controller=>'homepage',:action=>'login')
    return false # halts the before_action
    else
    return true
    end
  end
  
 
   private

  def confirm_logged_in_user
    unless cookies[:user_id2].present?
      flash[:notice]="Please log in"
      redirect_to(:controller=>'Orders',:action=>'placeOrder')
    return false # halts the before_action
    else
    return true
    end
  end
  
  
  
  private
  def current_cart
    
        Cart.find(cookies[:xxx])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    cookies[:xxx] = cart.id
    cart
    end
end
