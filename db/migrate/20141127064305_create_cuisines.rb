class CreateCuisines < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.string :cuisine_name
      t.integer :hotel_id
      t.timestamps
    end
    add_index("cuisines","hotel_id")
  end
end
