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

ActiveRecord::Schema.define(version: 2020_12_28_153804) do

  create_table "facilities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "facility_name"
    t.string "email", default: "", null: false
    t.boolean "admin", default: false
    t.string "image"
    t.string "icon"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "facility_id"
    t.string "title"
    t.text "news"
    t.integer "status", default: 0, null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_information_on_facility_id"
  end

  create_table "inquiries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "message"
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_inquiries_on_facility_id"
  end

  create_table "memories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "resident_id"
    t.string "title"
    t.text "message"
    t.date "event_date"
    t.string "image0"
    t.string "image1"
    t.string "image2"
    t.string "image3"
    t.string "image4"
    t.string "image5"
    t.string "image6"
    t.string "image7"
    t.integer "add_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_memories_on_resident_id"
  end

  create_table "relatives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "resident_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resident_id"], name: "index_relatives_on_resident_id"
    t.index ["user_id"], name: "index_relatives_on_user_id"
  end

  create_table "request_mails", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "facility_id"
    t.string "title"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_request_mails_on_facility_id"
  end

  create_table "request_residents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "facility_id"
    t.string "req_name"
    t.string "req_phone"
    t.string "req_address"
    t.integer "req_approval", default: 0
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
    t.bigint "facility_id"
    t.string "name", null: false
    t.string "charge_worker"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_residents_on_facility_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "room_name"
    t.bigint "user_id"
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_id"], name: "index_rooms_on_facility_id"
    t.index ["room_name"], name: "index_rooms_on_room_name", unique: true
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "tag_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.bigint "tag_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_tag_images_on_tag_id"
    t.index ["user_id"], name: "index_tag_images_on_user_id"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password"
    t.boolean "admin", default: false
    t.string "phone"
    t.string "address"
    t.integer "postal_code"
    t.string "prefecture_name"
    t.string "address_city"
    t.string "address_street"
    t.text "image"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "token"
    t.string "meta"
    t.string "uid"
    t.string "provider"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "facility_users", "facilities"
  add_foreign_key "facility_users", "users"
  add_foreign_key "information", "facilities"
  add_foreign_key "inquiries", "facilities"
  add_foreign_key "memories", "residents"
  add_foreign_key "relatives", "residents"
  add_foreign_key "relatives", "users"
  add_foreign_key "request_mails", "facilities"
  add_foreign_key "request_residents", "facilities"
  add_foreign_key "request_residents", "users"
  add_foreign_key "reservations", "users"
  add_foreign_key "residents", "facilities"
  add_foreign_key "rooms", "facilities"
  add_foreign_key "rooms", "users"
  add_foreign_key "tag_images", "tags"
  add_foreign_key "tag_images", "users"
  add_foreign_key "tags", "users"
end
