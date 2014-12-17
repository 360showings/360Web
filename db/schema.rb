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

ActiveRecord::Schema.define(version: 20141216190423) do

  create_table "candidates", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name",       limit: 80, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", force: true do |t|
    t.integer  "listing_id"
    t.string   "content_type"
    t.string   "content_link"
    t.string   "caption"
    t.integer  "content_group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", force: true do |t|
    t.integer  "agent_id"
    t.integer  "mls_num",               null: false
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state",      limit: 2
    t.string   "zipcode",    limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "multilists", force: true do |t|
    t.string   "name",                 null: false
    t.string   "state",      limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: true do |t|
    t.integer  "company_id"
    t.string   "office_type",  limit: 32, null: false
    t.string   "mls_id",       limit: 8,  null: false
    t.string   "name",                    null: false
    t.string   "phone",        limit: 14
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state",        limit: 2
    t.string   "zipcode",      limit: 16
    t.string   "email"
    t.string   "office_logo"
    t.string   "office_image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offices", ["mls_id"], name: "index_offices_on_mls_id", unique: true

  create_table "profiles", force: true do |t|
    t.integer  "agent_id"
    t.text     "bio"
    t.string   "website"
    t.string   "facebook"
    t.string   "license"
    t.string   "designations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "realtors", force: true do |t|
    t.integer  "multilist_id"
    t.string   "first_name",             null: false
    t.string   "last_name",              null: false
    t.string   "agent_code"
    t.string   "office_code",  limit: 8
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "realtors", ["multilist_id", "agent_code"], name: "index_realtors_on_multilist_id_and_agent_code", unique: true

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "agent_code"
    t.string   "office_phone"
    t.string   "cell_phone"
    t.string   "image"
    t.integer  "office_id"
  end

  add_index "users", ["agent_code"], name: "index_users_on_agent_code", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
