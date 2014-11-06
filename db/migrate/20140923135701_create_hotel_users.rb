class CreateHotelUsers < ActiveRecord::Migration
  def up
    create_table :hotel_users do |t|
t.string "userName",:limit=>20
t.string "email",:limit=>100
t.string "password",:limit=>20
t.string "address1",:limit=>40
t.string "address2",:limit=>40
      t.timestamps
    end
    
  end
  def down
     drop_table :hotel_users
  end
end

