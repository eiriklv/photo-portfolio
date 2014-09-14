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

ActiveRecord::Schema.define(version: 20140914114345) do

  create_table "albums", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_id"
  end

  create_table "cams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_comments", force: true do |t|
    t.string   "identifier"
    t.integer  "photo_id"
    t.integer  "facebook_user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_comments", ["facebook_user_id"], name: "index_facebook_comments_on_facebook_user_id", using: :btree
  add_index "facebook_comments", ["photo_id"], name: "index_facebook_comments_on_photo_id", using: :btree

  create_table "facebook_users", force: true do |t|
    t.string   "identifier"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lens", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_facebook_users", force: true do |t|
    t.integer  "photo_id"
    t.integer  "facebook_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photo_facebook_users", ["facebook_user_id"], name: "index_photo_facebook_users_on_facebook_user_id", using: :btree
  add_index "photo_facebook_users", ["photo_id"], name: "index_photo_facebook_users_on_photo_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "position"
    t.integer  "views"
    t.integer  "cam_id"
    t.integer  "lens_id"
    t.integer  "iso"
    t.float    "aperture"
    t.string   "exposure"
    t.integer  "focal_distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "album_id"
    t.date     "date"
    t.string   "facebook_id"
    t.integer  "likes"
    t.integer  "comments"
    t.string   "photosight_url"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree
  add_index "photos", ["cam_id"], name: "index_photos_on_cam_id", using: :btree
  add_index "photos", ["lens_id"], name: "index_photos_on_lens_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "access_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
