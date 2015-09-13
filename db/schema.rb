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

ActiveRecord::Schema.define(version: 20150912023807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "uid"
    t.string   "nickname"
    t.string   "name"
    t.string   "image"
    t.string   "bio"
    t.string   "website"
    t.string   "token"
    t.string   "provider"
    t.string   "bcid"
    t.string   "bctoken"
    t.string   "store_hash"
  end

  add_index "brands", ["email"], name: "index_brands_on_email", unique: true, using: :btree
  add_index "brands", ["reset_password_token"], name: "index_brands_on_reset_password_token", unique: true, using: :btree

  create_table "followed_bys", force: :cascade do |t|
    t.integer  "followable_id"
    t.string   "followable_type"
    t.integer  "follower_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "followed_bys", ["followable_type", "followable_id"], name: "index_followed_bys_on_followable_type_and_followable_id", using: :btree
  add_index "followed_bys", ["follower_id"], name: "index_followed_bys_on_follower_id", using: :btree

  create_table "followers", force: :cascade do |t|
    t.string   "username"
    t.string   "profile_picture"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "order", force: :cascade do |t|
    t.integer  "shop_id",           null: false
    t.integer  "cents_per_like",    null: false
    t.float    "dollars_per_like",  null: false
    t.float    "max_total_allowed", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "order", ["shop_id"], name: "index_order_on_shop_id", using: :btree

  create_table "post", force: :cascade do |t|
    t.integer  "shopper_id",                       null: false
    t.integer  "order_id"
    t.string   "type",                             null: false
    t.text     "caption"
    t.string   "link",                             null: false
    t.string   "image",                            null: false
    t.string   "media_id",                         null: false
    t.text     "tagged_accounts",     default: [],              array: true
    t.integer  "followers_generated",              null: false
    t.integer  "likes",                            null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "post", ["order_id"], name: "index_post_on_order_id", using: :btree
  add_index "post", ["shopper_id"], name: "index_post_on_shopper_id", using: :btree

  create_table "reward", force: :cascade do |t|
    t.integer  "post_id",    null: false
    t.float    "total",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reward", ["post_id"], name: "index_reward_on_post_id", using: :btree

  create_table "shop", force: :cascade do |t|
    t.integer  "brand_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shop", ["brand_id"], name: "index_shop_on_brand_id", using: :btree

  create_table "shoppers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "name"
    t.string   "image"
    t.string   "bio"
    t.string   "website"
    t.string   "token"
    t.string   "follower_count"
    t.string   "following_count"
    t.string   "media_count"
  end

  add_index "shoppers", ["email"], name: "index_shoppers_on_email", unique: true, using: :btree
  add_index "shoppers", ["provider"], name: "index_shoppers_on_provider", using: :btree
  add_index "shoppers", ["reset_password_token"], name: "index_shoppers_on_reset_password_token", unique: true, using: :btree
  add_index "shoppers", ["uid"], name: "index_shoppers_on_uid", using: :btree

end
