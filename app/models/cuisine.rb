class Cuisine < ActiveRecord::Base
  has_many :categories
  belongs_to :hotel  
end
