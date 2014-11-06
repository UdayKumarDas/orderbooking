class AlterOrders < ActiveRecord::Migration
   def up
    add_column("orders","phone",:integer,:after=>"email")
   
  end
  def down
    remove_column("orders","phone",:integer,:after=>"email")
    
  end
end
