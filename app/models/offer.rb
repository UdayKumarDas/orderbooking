class Offer < ActiveRecord::Base
  #include ActiveModel::Validations
   has_many :categories
  has_many :menus
   has_many :line_items
    has_many :carts
    
    validate :end_date_get_greater_than_start_date_get
    
    def end_date_get_greater_than_start_date_get
      if !endDate_get.blank? and endDate_get < startDate_get
        errors.add(:endDate_get, "should be greater than start date")      
      end
    end
end
