class AlterOffers < ActiveRecord::Migration
  def up
    add_column("offers","catId_get",:integer)
    add_column("offers","menuName_get",:string)
    add_column("offers","qty_get",:integer)
    add_column("offers","disType_get",:string)
    add_column("offers","disAmountOrPercentage",:integer)
    add_column("offers","startDate_get",:date)
    add_column("offers","endDate_get",:date)
    add_column("offers","conditionsToGet",:integer)
    
    add_column("offers","catId_buy1",:integer)
    add_column("offers","menuName_buy1",:string)
    add_column("offers","qty_buy1",:integer)
    
    add_column("offers","catId_buy2",:integer)
    add_column("offers","menuName_buy2",:string)
    add_column("offers","qty_buy2",:integer)
    
    add_column("offers","catId_buy3",:integer)
    add_column("offers","menuName_buy3",:string)
    add_column("offers","qty_buy3",:integer)
    
    add_column("offers","catId_buy4",:integer)
    add_column("offers","menuName_buy4",:string)
    add_column("offers","qty_buy4",:integer)
    
    add_column("offers","catId_buy5",:integer)
    add_column("offers","menuName_buy5",:string)
    add_column("offers","qty_buy5",:integer)
   
   add_column("offers","offer_type",:string)
  end
  def down
     remove_column("offers","catId_get",:integer)
    remove_column("offers","menuName_get",:string)
    remove_column("offers","qty_get",:integer)
    remove_column("offers","disType_get",:string)
    remove_column("offers","disAmountOrPercentage",:integer)
    remove_column("offers","startDate_get",:date)
    remove_column("offers","endDate_get",:date)
    remove_column("offers","conditionsToGet",:integer)
    
    remove_column("offers","catId_buy1",:integer)
    remove_column("offers","menuName_buy1",:string)
    remove_column("offers","qty_buy1",:integer)
    
    remove_column("offers","catId_buy2",:integer)
    remove_column("offers","menuName_buy2",:string)
    remove_column("offers","qty_buy2",:integer)
    
    remove_column("offers","catId_buy3",:integer)
    remove_column("offers","menuName_buy3",:string)
    remove_column("offers","qty_buy3",:integer)
    
    remove_column("offers","catId_buy4",:integer)
    remove_column("offers","menuName_buy4",:string)
    remove_column("offers","qty_buy4",:integer)
    
    remove_column("offers","catId_buy5",:integer)
    remove_column("offers","menuName_buy5",:string)
    remove_column("offers","qty_buy5",:integer)
   remove_column("offers","offer_type",:string)
  end
end
