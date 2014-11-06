class CreateHotels < ActiveRecord::Migration
  def up
    create_table :hotels do |t|     
      t.string :hotel_Name
      t.string :hotel_address
      t.string :hotel_location
      t.integer :hotel_contactNo
      t.timestamps      
    end
  end
end
