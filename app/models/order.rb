class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :HotelUser
  
scope :sorted, lambda{order("hotels.hotel_name ASC")}
end
