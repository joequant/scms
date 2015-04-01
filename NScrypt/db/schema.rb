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

ActiveRecord::Schema.define(version: 20150329030609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.string   "version"
    t.text     "code"
    t.integer  "contract_id",  null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "author"
    t.string   "state"
    t.integer  "sc_event_id"
    t.integer  "template_id"
    t.string   "assign_state"
    t.string   "sign_state"
    t.boolean  "proposed"
    t.boolean  "posted"
    t.boolean  "rejected"
  end

  add_index "codes", ["contract_id"], name: "index_codes_on_contract_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "status"
    t.integer  "contact_user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  add_index "contacts", ["contact_user_id"], name: "index_contacts_on_contact_user_id", using: :btree
  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "owner"
    t.string   "status"
    t.integer  "signed_code_id"
    t.integer  "sc_event_id"
  end

  create_table "minutes", force: :cascade do |t|
    t.string   "message"
    t.integer  "contract_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "minutes", ["contract_id"], name: "index_minutes_on_contract_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "message"
    t.integer  "contract_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "notes", ["contract_id"], name: "index_notes_on_contract_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "parties", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "code_id"
    t.string   "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "role"
  end

  add_index "parties", ["code_id"], name: "index_parties_on_code_id", using: :btree
  add_index "parties", ["user_id"], name: "index_parties_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sc_event_runs", force: :cascade do |t|
    t.integer  "sc_event_id"
    t.datetime "run_at"
    t.string   "result"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sc_event_runs", ["sc_event_id"], name: "index_sc_event_runs_on_sc_event_id", using: :btree

  create_table "sc_events", force: :cascade do |t|
    t.text     "callback"
    t.integer  "code_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sc_events", ["code_id"], name: "index_sc_events_on_code_id", using: :btree

  create_table "sc_values", force: :cascade do |t|
    t.integer  "contract_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sc_values", ["contract_id"], name: "index_sc_values_on_contract_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "sc_event_id", null: false
    t.datetime "timestamp"
    t.string   "argument"
    t.boolean  "recurrent"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "schedules", ["sc_event_id"], name: "index_schedules_on_sc_event_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.string   "code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "templates", ["user_id"], name: "index_templates_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "legal_name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "wallets", force: :cascade do |t|
    t.string   "currency"
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "wallets", ["user_id"], name: "index_wallets_on_user_id", using: :btree

  add_foreign_key "codes", "contracts"
  add_foreign_key "codes", "sc_events"
  add_foreign_key "codes", "templates"
  add_foreign_key "codes", "users", column: "author"
  add_foreign_key "contacts", "users"
  add_foreign_key "contacts", "users", column: "contact_user_id"
  add_foreign_key "contracts", "codes", column: "signed_code_id"
  add_foreign_key "contracts", "sc_events"
  add_foreign_key "contracts", "users", column: "owner"
  add_foreign_key "minutes", "contracts"
  add_foreign_key "notes", "contracts"
  add_foreign_key "notes", "users"
  add_foreign_key "parties", "codes"
  add_foreign_key "parties", "users"
  add_foreign_key "sc_event_runs", "sc_events"
  add_foreign_key "sc_events", "codes"
  add_foreign_key "sc_values", "contracts"
  add_foreign_key "schedules", "sc_events"
  add_foreign_key "templates", "users"
  add_foreign_key "wallets", "users"
end
