class CreateUsers < ActiveRecord::Migration
   def up
   create_table :users do |t|
t.string "first_name",:limit=>25
t.string "last_name",:limit=>50
t.string "email",:null=>false,:limit=>100
t.string "username",:limit=>50  
t.string "password",:limit=>40 
t.integer "hotel_id"
      t.timestamps
    end
     add_index("users","hotel_id")
  end
end
def down
  drop_table :users
end
