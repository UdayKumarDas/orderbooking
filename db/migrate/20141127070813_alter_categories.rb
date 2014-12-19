class AlterCategories < ActiveRecord::Migration
  def up
    add_column("categories","cuisine_id",:integer,:after=>"hotel_id")
    add_index("categories","cuisine_id")
  end
  def down
    remove_index("categories","cuisine_id")
    remove_column("categories","cuisine_id",:integer,:after=>"hotel_id")
  end
end
