class CreateOrders < ActiveRecord::Migration
  
 create_table :orders do |t|
    t.string :name
    t.text :address,:limit=>500
    t.string :email
    t.string :pay_type
    t.string :phone,:limit=>25
    t.integer :hotel_user_id
    t.timestamps
  end

  add_index("orders","hotel_user_id")
end
