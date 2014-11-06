class CreateMenus < ActiveRecord::Migration
  def up
    create_table :menus do |t|
    t.integer 'hotel_id'      
    t.string 'menu_item_name'
    t.integer 'price'
    t.string 'item_type'
      t.timestamps
    end
    add_index("menus","hotel_id")#index is used to search 
  end
  end

