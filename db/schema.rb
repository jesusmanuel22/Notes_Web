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

ActiveRecord::Schema.define(version: 20180511161334) do

  create_table "collection_notes", force: :cascade do |t|
    t.integer "id_collection"
    t.integer "id_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collection_users", force: :cascade do |t|
    t.integer "id_collection"
    t.integer "id_user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friends", force: :cascade do |t|
    t.integer "id_user1"
    t.integer "id_user2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendship_requests", force: :cascade do |t|
    t.integer "sender"
    t.integer "receiver"
    t.string "text"
    t.string "expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_notes", force: :cascade do |t|
    t.integer "id_user"
    t.integer "id_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "avatar"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
