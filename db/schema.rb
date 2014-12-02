# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141127070813) do

  create_table "carts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "hotel_id"
    t.integer  "cuisine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["cuisine_id"], name: "index_categories_on_cuisine_id", using: :btree
  add_index "categories", ["hotel_id"], name: "index_categories_on_hotel_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "cityName",   limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cuisines", force: true do |t|
    t.string   "cuisine_name"
    t.integer  "hotel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cuisines", ["hotel_id"], name: "index_cuisines_on_hotel_id", using: :btree

  create_table "hotel_users", force: true do |t|
    t.string   "userName",        limit: 20
    t.string   "email",           limit: 100
    t.string   "password_digest"
    t.string   "address1",        limit: 40
    t.string   "address2",        limit: 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phoneNo"
    t.string   "city"
    t.string   "pinCode"
    t.string   "UserType"
    t.string   "hotel_id"
    t.string   "address3"
    t.string   "address4"
    t.string   "address5"
    t.string   "address6"
    t.string   "address7"
    t.string   "address8"
    t.string   "address9"
  end

  create_table "hotels", force: true do |t|
    t.string   "hotel_Name"
    t.string   "hotel_address"
    t.string   "hotel_location"
    t.integer  "hotel_contactNo"
    t.string   "hotelImage"
    t.string   "from_time"
    t.string   "to_time"
    t.string   "amOrPm"
    t.string   "amOrPm1"
    t.boolean  "Coupons_accepted"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
    t.boolean  "sat"
    t.boolean  "sun"
    t.integer  "min_order"
    t.string   "veg"
    t.string   "non_veg"
    t.string   "payment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", force: true do |t|
    t.integer  "menu_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  create_table "locations", force: true do |t|
    t.string   "Locationname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.integer  "hotel_id"
    t.string   "menu_item_name"
    t.integer  "price"
    t.string   "item_type"
    t.integer  "category_id"
    t.integer  "veg"
    t.integer  "non_veg"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "menus", ["category_id"], name: "index_menus_on_category_id", using: :btree
  add_index "menus", ["hotel_id"], name: "index_menus_on_hotel_id", using: :btree

  create_table "offers", force: true do |t|
    t.integer  "hotel_id"
    t.integer  "percentageOff"
    t.integer  "amountforDiscount"
    t.datetime "startDate"
    t.datetime "endDate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "catId_get"
    t.string   "menuName_get"
    t.integer  "qty_get"
    t.string   "disType_get"
    t.integer  "disAmountOrPercentage"
    t.date     "startDate_get"
    t.date     "endDate_get"
    t.integer  "conditionsToGet"
    t.integer  "catId_buy1"
    t.string   "menuName_buy1"
    t.integer  "qty_buy1"
    t.integer  "catId_buy2"
    t.string   "menuName_buy2"
    t.integer  "qty_buy2"
    t.integer  "catId_buy3"
    t.string   "menuName_buy3"
    t.integer  "qty_buy3"
    t.integer  "catId_buy4"
    t.string   "menuName_buy4"
    t.integer  "qty_buy4"
    t.integer  "catId_buy5"
    t.string   "menuName_buy5"
    t.integer  "qty_buy5"
    t.string   "offer_type"
  end

  create_table "orders", force: true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "email"
    t.string   "pay_type"
    t.string   "phone",         limit: 25
    t.integer  "hotel_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["hotel_user_id"], name: "index_orders_on_hotel_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 100, null: false
    t.string   "username",        limit: 50
    t.integer  "hotel_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  add_index "users", ["hotel_id"], name: "index_users_on_hotel_id", using: :btree

end
