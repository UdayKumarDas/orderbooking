class OffersController < ApplicationController
  respond_to :html
  def index
    @offers=Offer.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
    @discountOnAmount=Offer.where(:offer_type=>'discountOnAmount' )
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    @categories=Category.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
    @menus=Menu.where(:category_id=>params[:catId_get])
    @catId=params[:catId_get]
    @discount_with_percentage= Offer.where(:disType_get =>'%')
    @discount_with_currency= Offer.where(:disType_get =>'Rs.')
  end

  def show
    @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    @categories=Category.where(:hotel_id=>cookies[:hotel_id_for_login_user] )
    @offers=Offer.where(:hotel_id=>cookies[:hotel_id_for_login_user] )

  end

  def create
    
    @offer=Offer.new(offer_params)

    #Save the object
    if @offer.save
      #If save succeeds,redirect to the index action
      @offer.update( :hotel_id=>cookies[:hotel_id_for_login_user],:offer_type=>'discountOnAmount')
      flash[:notice]="Offer Created Successfully"
      redirect_to(:controller=>'offers',:action=>'index')
    else
    #If save fails,redisplay the form so user can fix problems
      redirect_to(:controller=>'offers',:action=>'index')
      flash[:error]="End date should be greater than start date. "

    end
  end

  def combo
    @offer=Offer.new(offer_params)

    #Save the object
    if @offer.save
      #If save succeeds,redirect to the index action
      @offer.update( :hotel_id=>cookies[:hotel_id_for_login_user])
      redirect_to(:controller=>'offers',:action=>'show')
    else
    #If save fails,redisplay the form so user can fix problems
      redirect_to(:controller=>'offers',:action=>'index')
      flash[:error]="End date should be greater than start date. "
    end
  end

  def comboUpdate
    @offerx=Offer.order("created_at").last
    if @offerx.update_attributes(offer_params)
      if(@offerx.menuName_buy1.present? && @offerx.menuName_buy2==''  && @offerx.menuName_buy3=='' &&
      @offerx.menuName_buy4==''  && @offerx.menuName_buy5=='' )
        @offerx.update(:offer_type=>'buy1get1')
      end
      if(@offerx.menuName_buy1.present? && @offerx.menuName_buy2.present?  && @offerx.menuName_buy3=='' &&
      @offerx.menuName_buy4==''  && @offerx.menuName_buy5=='' )
        @offerx.update(:offer_type=>'buy2get1')
      end
      if(@offerx.menuName_buy1.present? && @offerx.menuName_buy2.present?  && @offerx.menuName_buy3.present? &&
      @offerx.menuName_buy4==''  && @offerx.menuName_buy5=='' )
        @offerx.update(:offer_type=>'buy3get1')
      end
      if(@offerx.menuName_buy1.present? && @offerx.menuName_buy2.present?  && @offerx.menuName_buy3.present? &&
      @offerx.menuName_buy4.present? && @offerx.menuName_buy5=='' )
        @offerx.update(:offer_type=>'buy4get1')
      end
      if(@offerx.menuName_buy1.present? && @offerx.menuName_buy2.present?  && @offerx.menuName_buy3.present? &&
      @offerx.menuName_buy4.present? && @offerx.menuName_buy5.present? )
        @offerx.update(:offer_type=>'buy5get1')
      end

      flash[:notice]="Offer Created Successfully"
      redirect_to(:controller=>'offers',:action=>'index')
    else
      endrender('show')
      flash[:notice]="Please Try Again "
    end
  end

  def new

  end

  def destroy
    @offer=Offer.find(params[:id])
    if @offer.destroy
      flash[:notice]="Offer deleted successfully."
      redirect_to(:controller=>'offers',:action=>'index')
    else
      flash[:notice]="Offer not Destroyed."
      endrender('index')

    end

  end

  def edit
  end

  def get_date
    @month= params[:month]
    @date= Time.days_in_month(@month)
    return @date
  end

  def offer_params
      params.require(:offer).permit(:startDate,:endDate,:hotel_id,:percentageOff,:amountforDiscount,:catId_get,:menuName_get,:qty_get,:disType_get,:disAmountOrPercentage,:startDate_get,:endDate_get,
      :conditionsToGet,:catId_buy1,:menuName_buy1,:qty_buy1,:catId_buy2,:menuName_buy2,:qty_buy2,:catId_buy3,:menuName_buy3,:qty_buy3,:catId_buy4,:menuName_buy4,:qty_buy4,:catId_buy5,:menuName_buy5,:qty_buy5)
    end
end
