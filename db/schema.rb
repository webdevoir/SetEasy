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

ActiveRecord::Schema.define(version: 20180808221831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budget_items", force: :cascade do |t|
    t.bigint "budget_id"
    t.string "item"
    t.boolean "rent_status"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rental_id"
    t.float "budgeted"
    t.string "payment"
    t.string "reference"
    t.integer "crew_id"
    t.index ["budget_id"], name: "index_budget_items_on_budget_id"
    t.index ["rental_id"], name: "index_budget_items_on_rental_id"
  end

  create_table "budgets", force: :cascade do |t|
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.string "name"
    t.float "budgeted"
    t.index ["location_id"], name: "index_budgets_on_location_id"
    t.index ["project_id"], name: "index_budgets_on_project_id"
  end

  create_table "crews", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "availability"
    t.string "skills"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.bigint "project_id"
    t.index ["project_id"], name: "index_crews_on_project_id"
  end

  create_table "crews_events", id: false, force: :cascade do |t|
    t.bigint "crew_id", null: false
    t.bigint "event_id", null: false
    t.index ["crew_id", "event_id"], name: "index_crews_events_on_crew_id_and_event_id"
  end

  create_table "email_lists", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.datetime "start"
    t.datetime "end"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.bigint "project_id"
    t.index ["location_id"], name: "index_events_on_location_id"
    t.index ["project_id"], name: "index_events_on_project_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "postal"
    t.string "city"
    t.string "province"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "interior"
    t.bigint "project_id"
    t.integer "number"
    t.index ["project_id"], name: "index_locations_on_project_id"
  end

  create_table "lookbooks", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "location_id"
    t.string "name"
    t.string "image"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_lookbooks_on_location_id"
    t.index ["project_id"], name: "index_lookbooks_on_project_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.string "email"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_users", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.float "budget"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "company"
    t.string "dresser_days"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.text "image"
    t.string "source"
    t.date "due_date"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "project_id"
    t.date "pick_date"
    t.index ["location_id"], name: "index_rentals_on_location_id"
    t.index ["project_id"], name: "index_rentals_on_project_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.bigint "project_id"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "desc"
    t.string "vendor"
    t.float "price"
    t.integer "rental_id"
    t.index ["location_id"], name: "index_sources_on_location_id"
    t.index ["project_id"], name: "index_sources_on_project_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stripe_card_token"
    t.bigint "plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "current_project"
    t.string "role"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "budget_items", "budgets"
  add_foreign_key "budget_items", "rentals"
  add_foreign_key "budgets", "locations"
  add_foreign_key "budgets", "projects"
  add_foreign_key "crews", "projects"
  add_foreign_key "events", "locations"
  add_foreign_key "events", "projects"
  add_foreign_key "locations", "projects"
  add_foreign_key "lookbooks", "locations"
  add_foreign_key "lookbooks", "projects"
  add_foreign_key "project_users", "projects"
  add_foreign_key "project_users", "users"
  add_foreign_key "rentals", "locations"
  add_foreign_key "rentals", "projects"
  add_foreign_key "sources", "locations"
  add_foreign_key "sources", "projects"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "users"
end
