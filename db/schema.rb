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

ActiveRecord::Schema.define(version: 20160903204652) do

  create_table "comments", force: :cascade do |t|
    t.text     "content",    null: false
    t.integer  "user_id",    null: false
    t.integer  "item_id"
    t.integer  "list_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_comments_on_item_id"
    t.index ["list_id"], name: "index_comments_on_list_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.integer  "user_id",                 null: false
    t.integer  "list_id",                 null: false
    t.integer  "rating",      default: 0, null: false
    t.integer  "comts",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["list_id"], name: "index_items_on_list_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "views",       default: 0
    t.string   "slug"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "role",                   default: "user"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.string   "vot",        null: false
    t.integer  "item_id",    null: false
    t.integer  "user_id"
    t.string   "user_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "user_id"], name: "index_votes_on_item_id_and_user_id", unique: true
    t.index ["item_id", "user_ip"], name: "index_votes_on_item_id_and_user_ip", unique: true
    t.index ["item_id"], name: "index_votes_on_item_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["user_ip"], name: "index_votes_on_user_ip"
  end

end
