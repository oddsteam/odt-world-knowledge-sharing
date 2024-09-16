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

ActiveRecord::Schema[7.2].define(version: 2024_09_16_042408) do
  create_table "endorsements", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "user_id"
    t.integer "endorsed_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "endorse_count", default: 0, null: false
    t.index ["skill_id"], name: "index_skills_users_on_skill_id"
    t.index ["user_id"], name: "index_skills_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "nickname"
    t.string "profile_picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login"
    t.string "encrypted_password"
    t.string "email", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider", limit: 50, default: ""
    t.string "uid", limit: 500, default: ""
    t.boolean "is_mentor", default: false
    t.string "bio", limit: 100, default: ""
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["is_mentor"], name: "index_users_on_is_mentor"
    t.index ["login"], name: "index_users_on_login"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "skills_users", "skills"
  add_foreign_key "skills_users", "users"
end
