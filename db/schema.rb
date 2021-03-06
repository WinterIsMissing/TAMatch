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

ActiveRecord::Schema.define(version: 20190201173112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "degree_program"
    t.boolean  "isTA", default: false
    t.boolean  "isGrader", default: false
    t.boolean  "isSG", default: false
    t.text     "advisor",         default: "none"
    t.integer  "years",           default: 0
    t.text     "preference_list", default: [],                  array: true
    t.text     "preferences",     default: [],                  array: true
    t.text     "antipref",        default: [],                  array: true
    t.text     "indifferent",     default: [],                  array: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "ta_count"
    t.integer  "grader_count"
    t.integer  "student_count"
    t.text     "course_info"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "instructor_preferences", force: :cascade do |t|
    t.text     "preferences"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_instructor_preferences_on_user_id", using: :btree
  end

  create_table "matches", force: :cascade do |t|
    t.string   "course"
    t.string   "label"
    t.integer  "applicant_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["applicant_id"], name: "index_matches_on_applicant_id", using: :btree
  end

  create_table "taapps", force: :cascade do |t|
    t.string   "degreeProgram"
    t.boolean  "isTA"
    t.boolean  "isGrader"
    t.boolean  "isSG"
    t.text     "pref",          default: [],              array: true
    t.text     "indifferent",   default: [],              array: true
    t.text     "antipref",      default: [],              array: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "email"
    t.string   "login_token"
    t.string   "token_generated_at"
    t.string   "auth_level"
    t.string   "uid"
    t.string   "provider"
    t.string   "image_url"
    t.string   "url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "instructor_preferences", "users"
  add_foreign_key "matches", "applicants"
end
