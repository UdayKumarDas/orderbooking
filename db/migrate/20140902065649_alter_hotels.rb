class AlterHotels < ActiveRecord::Migration
  def up
    add_column("hotels","min_order",:integer,:after=>"hotel_contactNo")
    add_column("hotels","hotelImage",:string,:after=>"hotel_contactNo")
    add_column("hotels","from_time",:time,:after=>"hotelImage")
    add_column("hotels","to_time",:time,:after=>"from_time")
    add_column("hotels","amOrPm",:string,:after=>"to_time")
    add_column("hotels","amOrPm1",:string,:after=>"amOrPm")
    add_column("hotels","Coupons_accepted",:boolean,:after=>"amOrPm1")
    add_column("hotels","mon",:boolean,:after=>"Coupons_accepted")
    add_column("hotels","tue",:boolean,:after=>"mon")
    add_column("hotels","wed",:boolean,:after=>"tue")
    add_column("hotels","thu",:boolean,:after=>"wed")
    add_column("hotels","fri",:boolean,:after=>"thu")
    add_column("hotels","sat",:boolean,:after=>"fri")
    add_column("hotels","sun",:boolean,:after=>"sat")

  end

  def down
    remove_column("hotels","min_order",:integer,:after=>"hotel_contactNo")
    remove_column("hotels","hotelImage",:string,:after=>"hotel_contactNo")
    remove_column("hotels","from_time",:time,:after=>"hotelImage")
    remove_column("hotels","to_time",:time,:after=>"from_time")
    remove_column("hotels","am",:string,:after=>"to_time")
    remove_column("hotels","pm",:string,:after=>"am")
    remove_column("hotels","Coupons_accepted",:boolean,:after=>"pm")
    remove_column("hotels","mon",:boolean,:after=>"Coupons_accepted")
    remove_column("hotels","tue",:boolean,:after=>"mon")
    remove_column("hotels","wed",:boolean,:after=>"tue")
    remove_column("hotels","thu",:boolean,:after=>"wed")
    remove_column("hotels","fri",:boolean,:after=>"thu")
    remove_column("hotels","sat",:boolean,:after=>"fri")
    remove_column("hotels","sun",:boolean,:after=>"sat")
  end
end
