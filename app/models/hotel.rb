class Hotel < ActiveRecord::Base
  has_many :menus
  has_many :users
  has_many :categories
  has_many :offers
  has_many :cuisine
  
  geocoded_by :hotel_address
  after_validation :geocode

   mount_uploader :hotelImage, ImageUploader
  scope :sorted, lambda{order("hotels.hotel_location ASC")}
 scope :with_cuisine, lambda { |cuisines|   where(cuisine_name: [*cuisines]) }
 
 
end
