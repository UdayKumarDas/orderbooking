class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer "hotel_id"      
      t.integer "percentageOff"
      t.integer "amountforDiscount"
      t.datetime "startDate"
      t.datetime "endDate"

      t.timestamps
    end

  end
end
