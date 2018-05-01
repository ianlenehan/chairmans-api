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

ActiveRecord::Schema.define(version: 20180207022403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.text     "full_name"
    t.text     "nick_name"
    t.text     "avatar_url"
    t.boolean  "hat_holder"
    t.boolean  "immunity"
    t.text     "handicap"
    t.text     "golflink_number"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "results", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "winner"
    t.integer  "loser"
    t.date     "round_date"
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "score"
    t.integer  "player_id"
    t.date     "round_date"
  end

end
