class AlterMenus < ActiveRecord::Migration
  def up
    
    add_column("menus","category_id",:integer,:after=>"item_type")
    add_index("menus","category_id")
    
  end
end
