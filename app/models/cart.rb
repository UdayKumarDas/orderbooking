class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  belongs_to :offer
  def add_menu(menu_id)
    current_item = line_items.where(:menu_id => menu_id).first
    if current_item
    current_item.quantity +=1
    else
      current_item = LineItem.new(:menu_id => menu_id)
      line_items << current_item
    end
    current_item
  end

  def sub_menu(menu_id)
    current_item = line_items.where(:menu_id => menu_id).first

    if current_item
      current_item.update_column( :quantity, current_item.quantity - 1 )
    end

    if current_item.quantity == 0
    current_item.destroy
    end

    current_item
  end

  def sub_menu1(menu_id)
    current_item = line_items.where(:menu_id => menu_id).first
    if current_item.quantity>1
      if current_item
      current_item.quantity -= 1
      end
    current_item
    end
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
  def discount_on_percentage
    @offer=Offer.where(:hotel_id=>cookies[:hotelId])
    
  end
end
