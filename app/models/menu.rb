class Menu < ActiveRecord::Base
  belongs_to :hotel
  belongs_to :category
  has_many :line_items
 mount_uploader :image, ImageUploader

  scope :sorted, lambda{order("menus.menu_item_name ASC")}
   
  
 before_destroy :ensure_not_referenced_by_any_line_item
# ensure that there are no line items referencing this product
def ensure_not_referenced_by_any_line_item
if line_items.count.zero?
return true
else
errors[:base] << "Line Items present"
return false
end
end


end

