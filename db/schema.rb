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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100917203435) do

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "town"
    t.string   "zipcode"
    t.string   "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "business_id"
    t.integer  "category_id"
    t.string   "short_description"
    t.text     "long_description"
    t.date     "valid_from"
    t.date     "valid_until"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["business_id"], :name => "index_coupons_on_business_id"
  add_index "coupons", ["category_id"], :name => "index_coupons_on_category_id"

end
