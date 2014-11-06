class CreateCategories < ActiveRecord::Migration
 def up
    create_table :categories do |t|
      t.string 'name'
      t.integer 'hotel_id'
      t.timestamps
    end
    add_index("categories","hotel_id")
  end
  def down
    drop_table :categories
  end
end
