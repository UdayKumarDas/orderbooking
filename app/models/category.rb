class Category < ActiveRecord::Base
  has_many :menus
  belongs_to :hotel
  belongs_to :offer
  belongs_to :cuisine
  scope :sorted, lambda{order("hotels.hotel_name ASC")}
   #mount_uploader :image, ImageUploader
end
