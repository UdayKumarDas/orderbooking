class CuisinesController < ApplicationController
  
  # GET /cuisines
  # GET /cuisines.json
  def index
     @hotel=Hotel.find(cookies[:hotel_id_for_login_user])
    @cuisines=Cuisine.where(:hotel_id=>cookies[:hotel_id_for_login_user])
    if params[:cuisineid1].present?
      @cuisine=Cuisine.find(params[:cuisineid1])
    end
  end

  # GET /cuisines/1
  # GET /cuisines/1.json
  def show
  end

  # GET /cuisines/new
  def new

  end

  # GET /cuisines/1/edit
  def edit
  end

  # POST /cuisines
  # POST /cuisines.json
  def create

    #@cuisines=Cuisine.where(:hotel_id=>cookies[:hotel_id_for_login_user])
    @cuisine = Cuisine.new(cuisine_params)

    if @cuisine.save
      @cuisine.update_attributes(:hotel_id=> cookies[:hotel_id_for_login_user])
      flash[:notice]="Cuisine successfully created"
      redirect_to(:action=>'index')
    else
       flash[:notice]="Cuisine not created, please try again!"
      redirect_to(:action=>'index')

    end
  end

  # PATCH/PUT /cuisines/1
  # PATCH/PUT /cuisines/1.json
  def update
    @cuisine1=Cuisine.find(params[:cuisineid1])
    if @cuisine1.update_attributes(cuisine_params1)
       flash[:notice]="Cuisine successfully updated"
      redirect_to(:action=>'index')
    else
       flash[:notice]="Cuisine not updated, please try again!"
      redirect_to(:action=>'index')
    end
  end

  # DELETE /cuisines/1
  # DELETE /cuisines/1.json
  def destroy
    @cuisine=Cuisine.find(params[:cuisineid])
    @cuisine.destroy
    flash[:notice]="Cuisine successfully deleted"
    redirect_to(:action=>'index')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  

  # Never trust parameters from the scary internet, only allow the white list through.
  def cuisine_params
    params.require(:cuisine).permit(:cuisine_name)
  end
  
  def cuisine_params1
    params.require(:cuisine).permit(:cuisine_name)
  end
end
