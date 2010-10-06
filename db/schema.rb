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

ActiveRecord::Schema.define(:version => 20101006195414) do

  create_table "admin_users", :force => true do |t|
    t.string   "login"
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["login"], :name => "index_admin_users_on_login", :unique => true

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "town"
    t.string   "zipcode"
    t.string   "website_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses", ["town"], :name => "index_businesses_on_town"

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "prints",             :default => 0
    t.float    "value",              :default => 0.0
    t.boolean  "featured"
    t.boolean  "online_only"
  end

  add_index "coupons", ["business_id"], :name => "index_coupons_on_business_id"
  add_index "coupons", ["category_id"], :name => "index_coupons_on_category_id"

  create_table "savings", :force => true do |t|
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
