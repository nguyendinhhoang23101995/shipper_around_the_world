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

ActiveRecord::Schema.define(version: 20161117133650) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "id_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_admins_on_user_id", using: :btree
  end

  create_table "contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.date     "deadline"
    t.string   "bank_account_a"
    t.string   "bank_account_b"
    t.integer  "state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "report_id"
    t.integer  "user_id"
    t.index ["report_id"], name: "index_contracts_on_report_id", using: :btree
    t.index ["user_id"], name: "index_contracts_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "request_id"
    t.index ["request_id"], name: "index_messages_on_request_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "product_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "price"
    t.string   "origin"
<<<<<<< HEAD
    t.float    "weight",          limit: 24
    t.integer  "state",                      default: 0
    t.string   "content"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
    t.integer  "product_type_id"
    t.integer  "contract_id"
    t.index ["contract_id"], name: "index_requests_on_contract_id", using: :btree
    t.index ["product_type_id"], name: "index_requests_on_product_type_id", using: :btree
    t.index ["user_id"], name: "index_requests_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phonenumber"
    t.float    "rank",            limit: 24, default: 0.0
    t.integer  "totalvote",                  default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "admins", "users"
  add_foreign_key "contracts", "reports"
  add_foreign_key "contracts", "users"
  add_foreign_key "messages", "requests"
  add_foreign_key "messages", "users"
  add_foreign_key "requests", "contracts"
  add_foreign_key "requests", "product_types"
  add_foreign_key "requests", "users"
end
