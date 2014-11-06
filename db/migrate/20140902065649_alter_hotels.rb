class AlterHotels < ActiveRecord::Migration
  def up
    add_column("hotels","min_order",:integer,:after=>"hotel_contactNo")
    add_column("hotels","hotelImage",:string,:after=>"hotel_contactNo")
  end
  def down
    remove_column("hotels","min_order",:integer,:after=>"hotel_contactNo")
    remove_column("hotels","hotelImage",:string,:after=>"hotel_contactNo")
  end
end
