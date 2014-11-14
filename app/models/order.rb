class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  belongs_to :hotelUser
  
scope :sorted, lambda{order("hotels.hotel_name ASC")}
end
