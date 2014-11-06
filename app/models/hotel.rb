class Hotel < ActiveRecord::Base
  has_many :menus
  has_many :users
  has_many :categories
  has_many :offers
   mount_uploader :hotelImage, ImageUploader
  scope :sorted, lambda{order("hotels.hotel_location ASC")}
end
