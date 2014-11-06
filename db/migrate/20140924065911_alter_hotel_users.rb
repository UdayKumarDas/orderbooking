class AlterHotelUsers < ActiveRecord::Migration
   def up          
    rename_column("hotel_users","password","hashed_password") 
    add_column("hotel_users","phoneNo",:integer)  
    add_column("hotel_users","city",:string)  
     add_column("hotel_users","pinCode",:string) 
      add_column("hotel_users","UserType",:string)   
      add_column("hotel_users","hotel_id",:string)   
  end
  
  def down
   rename_column("hotel_users","hashed_password","password")  
   remove_column("hotel_users","phoneNo",:integer)  
    remove_column("hotel_users","city",:string)
    remove_column("hotel_users","pinCode",:string)
    remove_column("hotel_users","UserType",:string)
    remove_column("hotel_users","hotel_id",:string)

  end

end
