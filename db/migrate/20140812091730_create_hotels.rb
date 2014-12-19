class CreateHotels < ActiveRecord::Migration
  def up
    create_table :hotels do |t|     
      t.string :hotel_Name
      t.string :hotel_address
      t.string :hotel_location
      t.integer :hotel_contactNo
      t.string :veg
      t.string :non_veg
      t.string :payment_type
      t.timestamps      
    end
    def down
      drop_table(:hotels)
    end
  end
end
