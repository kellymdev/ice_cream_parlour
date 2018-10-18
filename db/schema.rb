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

ActiveRecord::Schema.define(version: 2018_10_17_231449) do

  create_table "days", force: :cascade do |t|
    t.integer "game_id"
    t.integer "temperature"
    t.decimal "milk_price"
    t.decimal "sugar_price"
    t.integer "ice_creams_made"
    t.integer "ice_creams_sold"
    t.decimal "ice_cream_price"
    t.decimal "profit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_days_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inventories", force: :cascade do |t|
    t.integer "game_id"
    t.integer "milk", default: 0
    t.integer "sugar", default: 0
    t.integer "ice_creams", default: 0
    t.decimal "balance", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_inventories_on_game_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "day_id"
    t.string "ingredient"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["day_id"], name: "index_purchases_on_day_id"
  end

end
