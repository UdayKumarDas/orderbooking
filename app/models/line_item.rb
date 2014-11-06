class LineItem < ActiveRecord::Base
  belongs_to :menu
belongs_to :cart
belongs_to :order
belongs_to :offer
def total_price
menu.price * quantity
end
def total_quantity
  cookies[:qty1]=LineItem.quantity
end
#cookies[:qty1]=quantity
end
