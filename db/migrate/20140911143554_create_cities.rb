class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
t.string :cityName,:limit=>'40'
      t.timestamps
    end
  end
end
