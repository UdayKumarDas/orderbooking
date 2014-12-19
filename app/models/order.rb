class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  belongs_to :hotelUser
  has_many :carts
scope :sorted, lambda{order("hotels.hotel_name ASC")}

def self.search(search)
  if search
 where('orderId LIKE ?',"%#{search}%")
    else
  all
  end
end
end
