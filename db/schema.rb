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

ActiveRecord::Schema.define(version: 2020_10_02_170300) do

  create_table "facilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "facility_name"
    t.boolean "admin", default: false
    t.boolean "facility_admin", default: false
    t.string "image"
    t.index ["email"], name: "index_facilities_on_email", unique: true
    t.index ["reset_password_token"], name: "index_facilities_on_reset_password_token", unique: true
  end

  create_table "facility_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_facility_users_on_facility_id"
    t.index ["user_id"], name: "index_facility_users_on_user_id"
  end

  create_table "information", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "news"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "facility_id"
    t.index ["facility_id"], name: "index_information_on_facility_id"
  end

  create_table "relatives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_relatives_on_resident_id"
    t.index ["user_id"], name: "index_relatives_on_user_id"
  end

  create_table "request_residents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "req_name"
    t.string "req_phone"
    t.string "req_address"
    t.integer "req_approval", default: 0
    t.bigint "user_id"
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_request_residents_on_facility_id"
    t.index ["user_id"], name: "index_request_residents_on_user_id"
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.date "calendar_day"
    t.date "reservation_time"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "residents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "charge_worker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "facility_id"
    t.index ["facility_id"], name: "index_residents_on_facility_id"
  end

  create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password"
    t.string "room_name"
    t.boolean "admin", default: false
    t.boolean "floor_authority", default: false
    t.string "resident_name1"
    t.string "resident_name2"
    t.string "phone"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "provider"
    t.string "uid"
    t.string "meta"
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "facility_users", "facilities"
  add_foreign_key "facility_users", "users"
  add_foreign_key "information", "facilities"
  add_foreign_key "relatives", "residents"
  add_foreign_key "relatives", "users"
  add_foreign_key "request_residents", "facilities"
  add_foreign_key "request_residents", "users"
  add_foreign_key "reservations", "users"
  add_foreign_key "residents", "facilities"
end
