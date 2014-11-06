class HotelUser < ActiveRecord::Base
  belongs_to :order
  has_secure_password
end
