class AlterMenus < ActiveRecord::Migration
  def up
    
    add_column("menus","category_id",:integer,:after=>"item_type")
    add_index("menus","category_id")
     add_column("menus","veg",:integer,:after=>"category_id")
      add_column("menus","non_veg",:integer,:after=>"veg")
  end
end
