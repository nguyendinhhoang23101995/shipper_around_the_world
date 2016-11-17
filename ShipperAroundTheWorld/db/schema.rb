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

ActiveRecord::Schema.define(version: 20161117132628) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "users_id"
    t.string   "id_card"
    t.index ["users_id"], name: "index_admins_on_users_id", using: :btree
  end

  create_table "contracts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.date     "deadline"
    t.string   "bank_account_a"
    t.string   "bank_account_b"
    t.integer  "state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "reports_id"
    t.integer  "users_id"
    t.index ["reports_id"], name: "index_contracts_on_reports_id", using: :btree
    t.index ["users_id"], name: "index_contracts_on_users_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "users_id"
    t.integer  "requests_id"
    t.index ["requests_id"], name: "index_messages_on_requests_id", using: :btree
    t.index ["users_id"], name: "index_messages_on_users_id", using: :btree
  end

  create_table "product_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "note"
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
    t.float    "weight",           limit: 24
    t.integer  "state"
    t.string   "content"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "users_id"
    t.integer  "product_types_id"
    t.integer  "contracts_id"
    t.index ["contracts_id"], name: "index_requests_on_contracts_id", using: :btree
    t.index ["product_types_id"], name: "index_requests_on_product_types_id", using: :btree
    t.index ["users_id"], name: "index_requests_on_users_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "password_digest"
    t.string   "phonenumber"
    t.float    "rank",            limit: 24
    t.integer  "totalvote"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "admins", "users", column: "users_id"
  add_foreign_key "contracts", "reports", column: "reports_id"
  add_foreign_key "contracts", "users", column: "users_id"
  add_foreign_key "messages", "requests", column: "requests_id"
  add_foreign_key "messages", "users", column: "users_id"
  add_foreign_key "requests", "contracts", column: "contracts_id"
  add_foreign_key "requests", "product_types", column: "product_types_id"
  add_foreign_key "requests", "users", column: "users_id"
end
