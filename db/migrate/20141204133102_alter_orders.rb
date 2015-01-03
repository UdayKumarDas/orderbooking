class AlterOrders < ActiveRecord::Migration
  def up
    add_column("orders","order_time",:datetime,:after=>'orderId')
    add_column("orders","order_delivery_time",:datetime,:after=>'order_time')
     add_column("orders","total_amount",:float,:after=>'order_delivery_time')
      add_column("orders","tax",:float,:after=>'total_amount')
       add_column("orders","discount",:float,:after=>'tax')
        add_column("orders","final_total",:float,:after=>'discount')
        add_column("orders","userId",:integer,:after=>'final_total')
         add_column("orders","cartId",:integer,:after=>'userId')
  end
  def down
    
     remove_column("orders","order_time",:datetime,:after=>'orderId')
    remove_column("orders","order_delivery_time",:datetime,:after=>'order_time')
     remove_column("orders","total_amount",:float,:after=>'order_delivery_time')
      remove_column("orders","tax",:float,:after=>'total_amount')
       remove_column("orders","discount",:float,:after=>'tax')
        remove_column("orders","final_total",:float,:after=>'discount')
        remove_column("orders","userId",:integer,:after=>'final_total')
        remove_column("orders","cartId",:integer,:after=>'userId')
  end
end
