class User < ActiveRecord::Base
  belongs_to :hotel
  has_secure_password
   scope :sorted, lambda{order("categories.name ASC")}
end
