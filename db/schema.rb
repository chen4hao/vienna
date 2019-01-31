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

ActiveRecord::Schema.define(version: 2019_01_30_092419) do

  create_table "cart_items", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.date "day"
    t.integer "price", default: 0
    t.integer "add_bed_no", default: 0
    t.integer "add_bed_fee", default: 0
    t.integer "adult_no", default: 0
    t.integer "kid_no", default: 0
    t.integer "baby_no", default: 0
    t.integer "cart_id"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.string "mobile"
    t.string "country"
    t.string "id_no"
    t.date "birthday"
    t.string "job"
    t.string "tel"
    t.string "address"
    t.string "email"
    t.string "reminder"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "price", default: 0
    t.integer "item_id"
    t.integer "adult_no", default: 0
    t.integer "kid_no", default: 0
    t.integer "baby_no", default: 0
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.date "checkin_date"
    t.date "checkout_date"
    t.string "aasm_state"
    t.string "source"
    t.integer "room_subtotal", default: 0
    t.integer "bed_subtotal", default: 0
    t.integer "service_subtotal", default: 0
    t.integer "total", default: 0
    t.integer "downpay", default: 0
    t.integer "credit_card", default: 0
    t.integer "balance", default: 0
    t.string "pay_type"
    t.string "pay_info"
    t.string "created_by"
    t.string "updated_by"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "sex"
    t.string "mobile"
    t.string "country"
    t.string "id_no"
    t.date "birthday"
    t.string "job"
    t.string "tel"
    t.string "address"
    t.string "email"
    t.string "reminder"
    t.string "note"
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  create_table "room_calendars", force: :cascade do |t|
    t.date "day"
    t.integer "day_mode", default: 0
    t.string "day_info"
    t.string "r301"
    t.string "r302"
    t.string "r303"
    t.string "r305"
    t.string "r306"
    t.string "r101"
    t.string "r102"
    t.string "r103"
    t.string "r105"
    t.string "r201"
    t.string "r202"
    t.string "r203"
    t.string "r205"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "no"
    t.string "name"
    t.integer "list_price", default: 0
    t.integer "holiday_price", default: 0
    t.integer "hotday_price", default: 0
    t.integer "weekday_price", default: 0
    t.integer "custom_price", default: 0
    t.integer "add_bed_fee", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.integer "list_price", default: 0
    t.integer "custom_price", default: 0
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "title"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
