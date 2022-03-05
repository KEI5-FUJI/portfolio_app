# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_05_062359) do

  create_table "messagerooms", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.integer "guest_id", null: false
    t.integer "request_id", null: false
    t.index ["owner_id", "guest_id", "request_id"], name: "index_messagerooms_on_owner_id_and_guest_id_and_request_id", unique: true
    t.index ["request_id"], name: "index_messagerooms_on_request_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "message"
    t.integer "user_id", null: false
    t.integer "messageroom_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["messageroom_id"], name: "index_messages_on_messageroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.string "request_name"
    t.boolean "is_solved?", default: false, null: false
    t.string "reward"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "request_detail"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "allow_password_change", default: false
    t.string "name"
    t.string "now_place"
    t.float "lat"
    t.float "lng"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "messagerooms", "requests"
  add_foreign_key "messages", "messagerooms"
  add_foreign_key "messages", "users"
  add_foreign_key "requests", "users"
end
