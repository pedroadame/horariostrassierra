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

ActiveRecord::Schema.define(version: 20160604141349) do

  create_table "class_hours", force: :cascade do |t|
    t.integer  "teacher_id", null: false
    t.integer  "group_id",   null: false
    t.integer  "room_id",    null: false
    t.integer  "subject_id", null: false
    t.integer  "hour_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "class_hours", ["group_id"], name: "index_class_hours_on_group_id"
  add_index "class_hours", ["hour_id"], name: "index_class_hours_on_hour_id"
  add_index "class_hours", ["room_id"], name: "index_class_hours_on_room_id"
  add_index "class_hours", ["subject_id"], name: "index_class_hours_on_subject_id"
  add_index "class_hours", ["teacher_id"], name: "index_class_hours_on_teacher_id"

  create_table "groups", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.string   "level"
    t.string   "code"
    t.string   "course"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "teacher_id"
  end

  add_index "groups", ["teacher_id"], name: "index_groups_on_teacher_id"

  create_table "hours", force: :cascade do |t|
    t.string   "code"
    t.integer  "day"
    t.integer  "hour"
    t.string   "start"
    t.string   "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.string   "level"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.string   "level"
    t.string   "code"
    t.string   "course"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string   "abbreviation"
    t.string   "name"
    t.string   "level"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "teacher_id"
    t.string   "locale"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["teacher_id"], name: "index_users_on_teacher_id"

end
