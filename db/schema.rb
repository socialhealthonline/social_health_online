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

ActiveRecord::Schema.define(version: 2018_06_04_115737) do

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
    t.integer "support_type", default: 0, null: false
    t.string "contact_name"
    t.string "contact_phone_extension"
    t.string "contact_email"
    t.string "support_notes"
    t.datetime "date_added"
    t.string "contact_phone"
  end

  create_table "event_categories", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "social_event_log_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["social_event_log_id"], name: "index_event_categories_on_social_event_log_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "social_event_log_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["social_event_log_id"], name: "index_event_types_on_social_event_log_id"
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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "mailboxer_conversation_opt_outs", id: :serial, force: :cascade do |t|
    t.string "unsubscriber_type"
    t.integer "unsubscriber_id"
    t.integer "conversation_id"
    t.index ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
    t.index ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"
  end

  create_table "mailboxer_conversations", id: :serial, force: :cascade do |t|
    t.string "subject", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mailboxer_notifications", id: :serial, force: :cascade do |t|
    t.string "type"
    t.text "body"
    t.string "subject", default: ""
    t.string "sender_type"
    t.integer "sender_id"
    t.integer "conversation_id"
    t.boolean "draft", default: false
    t.string "notification_code"
    t.string "notified_object_type"
    t.integer "notified_object_id"
    t.string "attachment"
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.boolean "global", default: false
    t.datetime "expires"
    t.index ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
    t.index ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
    t.index ["notified_object_type", "notified_object_id"], name: "mailboxer_notifications_notified_object"
    t.index ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
    t.index ["type"], name: "index_mailboxer_notifications_on_type"
  end

  create_table "mailboxer_receipts", id: :serial, force: :cascade do |t|
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "notification_id", null: false
    t.boolean "is_read", default: false
    t.boolean "trashed", default: false
    t.boolean "deleted", default: false
    t.string "mailbox_type", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_delivered", default: false
    t.string "delivery_method"
    t.string "message_id"
    t.index ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
    t.index ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"
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
    t.boolean "hide_info_on_locator", default: false
    t.string "slug"
    t.datetime "welcome_kit_date"
    t.string "phone"
    t.string "contact_phone_extension"
    t.index ["slug"], name: "index_members_on_slug", unique: true
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rsvps", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rsvp_status", null: false
    t.index ["event_id"], name: "index_rsvps_on_event_id"
    t.index ["user_id"], name: "index_rsvps_on_user_id"
  end

  create_table "social_event_logs", force: :cascade do |t|
    t.date "event_date", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.integer "source", default: 0, null: false
    t.text "venue"
    t.integer "rating", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_social_event_logs_on_user_id"
  end

  create_table "social_fitness_logs", force: :cascade do |t|
    t.integer "individuals", null: false
    t.integer "groups", null: false
    t.integer "family", null: false
    t.integer "friends", null: false
    t.integer "colleagues", null: false
    t.integer "significant_other", null: false
    t.integer "local_community", null: false
    t.integer "overall", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_social_fitness_logs_on_user_id"
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

  add_foreign_key "event_categories", "social_event_logs"
  add_foreign_key "event_types", "social_event_logs"
  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
