class AlterHotelUsers < ActiveRecord::Migration
  def up
    rename_column("hotel_users","password","hashed_password")
    add_column("hotel_users","phoneNo",:string)
    add_column("hotel_users","city",:string)
    add_column("hotel_users","pinCode",:string)
    add_column("hotel_users","UserType",:string)
    add_column("hotel_users","hotel_id",:string)
    add_column("hotel_users","address3",:string)
    add_column("hotel_users","address4",:string)
    add_column("hotel_users","address5",:string)
    add_column("hotel_users","address6",:string)
    add_column("hotel_users","address7",:string)
    add_column("hotel_users","address8",:string)
    add_column("hotel_users","address9",:string)
  end

  def down
    rename_column("hotel_users","hashed_password","password")
    remove_column("hotel_users","phoneNo",:integer)
    remove_column("hotel_users","city",:string)
    remove_column("hotel_users","pinCode",:string)
    remove_column("hotel_users","UserType",:string)
    remove_column("hotel_users","hotel_id",:string)
    remove_column("hotel_users","address3",:string)
    remove_column("hotel_users","address4",:string)
    remove_column("hotel_users","address5",:string)
    remove_column("hotel_users","address6",:string)
    remove_column("hotel_users","address7",:string)
    remove_column("hotel_users","address8",:string)
    remove_column("hotel_users","address9",:string)

  end

end
