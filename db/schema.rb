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

ActiveRecord::Schema.define(version: 2018_04_07_184917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affiliates", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "phone"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "hide_info_on_locator", default: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "member_id", null: false
    t.string "title", null: false
    t.datetime "start_at", null: false
    t.string "time_zone", default: "Central Time (US & Canada)", null: false
    t.string "event_type", null: false
    t.string "state"
    t.string "city"
    t.string "location"
    t.string "url"
    t.text "details"
    t.boolean "private", default: false, null: false
    t.integer "rsvp_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type"], name: "index_events_on_event_type"
    t.index ["member_id"], name: "index_events_on_member_id"
    t.index ["private"], name: "index_events_on_private"
    t.index ["start_at"], name: "index_events_on_start_at"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "contact_name", null: false
    t.string "contact_email", null: false
    t.string "contact_phone", null: false
    t.integer "service_capacity", null: false
    t.date "account_start_date"
    t.date "account_end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "suspended", default: false, null: false
    t.text "bio"
    t.string "url"
    t.integer "primary_manager_id"
    t.string "events_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "enabled", default: true, null: false
    t.boolean "admin", default: false, null: false
    t.string "auth_token"
    t.string "password_digest", null: false
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.string "display_name"
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zip", null: false
    t.string "phone", null: false
    t.string "gender", null: false
    t.string "ethnicity", null: false
    t.date "birthdate", null: false
    t.string "time_zone", default: "Central Time (US & Canada)", null: false
    t.boolean "manager", default: false, null: false
    t.string "relationship_status"
    t.string "education_level"
    t.text "occupation"
    t.text "languages"
    t.text "hobbies"
    t.text "pet_peeves"
    t.text "bio"
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["enabled"], name: "index_users_on_enabled"
    t.index ["member_id"], name: "index_users_on_member_id"
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token"
  end

end
