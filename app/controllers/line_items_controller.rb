class LineItemsController < ApplicationController
  layout :false
  skip_before_filter :verify_authenticity_token
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  # GET /line_items
  # GET /line_items.json
  def index
    #@line_items = LineItem.all
    #redirect_to(:controller=>'menus',:hotel_id=> cookies[:hotelId])
    @quantityFromTxtBox=params[:quantity1]
    cookies[:quan]=params[:quantity]
    @cart = current_cart

    menu = Menu.find(params[:menu_id])
    @line_item = @cart.add_menu(menu.id)

    respond_to do |format|
      if @line_item.save
        if @quantityFromTxtBox.present?
          @qtyTotal=(@quantityFromTxtBox.to_i+@line_item.quantity.to_i)-1
          @line_item.update(:quantity=>@qtyTotal.to_i)
        end
        format.html { redirect_to(:back) }

        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end

    end

  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @quantityFromTxtBox=params[:quantity1]
    cookies[:quan]=params[:quantity]
    @cart = current_cart

    menu = Menu.find(params[:menu_id])
    @line_item = @cart.add_menu(menu.id)

    respond_to do |format|
      if @line_item.save
        if @quantityFromTxtBox.present?
          @qtyTotal=(@quantityFromTxtBox.to_i+@line_item.quantity.to_i)-1
          @line_item.update(:quantity=>@qtyTotal.to_i)
        end
        format.html { redirect_to(:back) }

        format.js { @current_item = @line_item }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end

    end

  end

  def minus
    @cart = current_cart
    menu = Menu.find(params[:menu_id])
    @line_item = @cart.sub_menu(menu.id)

    if @line_item
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
    else
      redirect_to(:back)
    end

  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html {  redirect_to(:back) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id1])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:menu_id, :cart_id)
  end

  def total_price
    menu.price * quantity
  end

  def total_quantity
    quantity += quantity
    cookies[:qty]=quantity
  end
end
