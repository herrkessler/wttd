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

ActiveRecord::Schema.define(version: 20150923123814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "icon"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "event_date"
    t.json     "user_status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "participants", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "synopsis"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.json     "venue_order"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "forename"
    t.string   "familyname"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.string   "avatar",          default: "avatar.png"
    t.string   "gravatarURL"
    t.string   "zip"
    t.text     "checkin",         default: [],                        array: true
    t.boolean  "confirmed"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "users_venues", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "venue_id"
  end

  add_index "users_venues", ["user_id"], name: "index_users_venues_on_user_id", using: :btree
  add_index "users_venues", ["venue_id"], name: "index_users_venues_on_venue_id", using: :btree

  create_table "venues", force: :cascade do |t|
    t.string   "title"
    t.text     "synopsis"
    t.text     "description"
    t.string   "street"
    t.string   "zip"
    t.string   "town"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "url"
    t.string   "instagram"
    t.text     "checkin",        default: [],                        array: true
    t.text     "likes",          default: [],                        array: true
    t.integer  "curator_rating"
    t.string   "user_rating",    default: [],                        array: true
    t.string   "average_rating", default: [],                        array: true
    t.string   "image_name"
    t.string   "gallery",        default: ["site.png"],              array: true
    t.string   "tags",           default: [],                        array: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

end
