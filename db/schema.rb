# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_08_071311) do

  create_table "rating_values", force: :cascade do |t|
    t.integer "value"
    t.string "name"
    t.string "color", default: "white"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "skill_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "rating_value_id"
    t.index ["rating_value_id"], name: "index_ratings_on_rating_value_id"
    t.index ["skill_id"], name: "index_ratings_on_skill_id"
    t.index ["user_id", "skill_id", "created_at"], name: "index_ratings_on_user_id_and_skill_id_and_created_at"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "skater_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "color", default: "white"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.integer "skills_category_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_skills_on_name", unique: true
    t.index ["skills_category_id"], name: "index_skills_on_skills_category_id"
  end

  create_table "skills_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "skater_status_id"
    t.string "password_digest"
    t.boolean "activated", default: false
    t.string "email"
    t.boolean "admin", default: false
    t.boolean "coach", default: false
    t.string "activation_digest"
    t.boolean "activating", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["admin", "coach"], name: "index_users_on_admin_and_coach"
    t.index ["email"], name: "index_users_on_email", unique: true, where: "activating"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["skater_status_id"], name: "index_users_on_skater_status_id"
  end

  add_foreign_key "ratings", "rating_values"
  add_foreign_key "users", "skater_statuses"
end
