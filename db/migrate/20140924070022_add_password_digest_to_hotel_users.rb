class AddPasswordDigestToHotelUsers < ActiveRecord::Migration
 def up
    remove_column "hotel_users","hashed_password"
    add_column "hotel_users","password_digest",:string,:after=>'email'
  end
  def down
     add_column "hotel_users","hashed_password"
    remove_column "hotel_users","password_digest",:after=>'email'
  end
end
