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

ActiveRecord::Schema[7.1].define(version: 2025_02_12_190538) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ai_responses", force: :cascade do |t|
    t.string "api_name"
    t.text "ai_response"
    t.bigint "nich_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nich_id"], name: "index_ai_responses_on_nich_id"
  end

  create_table "avatars", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "nich_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nich_id"], name: "index_avatars_on_nich_id"
  end

  create_table "hypothesis_results", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.bigint "nich_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nich_id"], name: "index_hypothesis_results_on_nich_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.bigint "nich_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nich_id"], name: "index_messages_on_nich_id"
  end

  create_table "niches", force: :cascade do |t|
    t.string "name"
    t.text "problem"
    t.text "fear"
    t.text "desire"
    t.integer "status", default: 0, null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_niches_on_project_id"
  end

  create_table "offers", force: :cascade do |t|
    t.text "question"
    t.text "answer"
    t.bigint "nich_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nich_id"], name: "index_offers_on_nich_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "scripts", force: :cascade do |t|
    t.text "question"
    t.bigint "nich_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nich_id"], name: "index_scripts_on_nich_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "ai_responses", "niches"
  add_foreign_key "avatars", "niches"
  add_foreign_key "hypothesis_results", "niches"
  add_foreign_key "messages", "niches"
  add_foreign_key "niches", "projects"
  add_foreign_key "offers", "niches"
  add_foreign_key "projects", "users"
  add_foreign_key "scripts", "niches"
end
