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

ActiveRecord::Schema[7.0].define(version: 2024_01_14_022816) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "group_id"
    t.index ["group_id"], name: "index_categories_on_group_id"
  end

  create_table "exercise_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "category_id", null: false
    t.integer "exercise_type_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_exercises_on_category_id"
    t.index ["exercise_type_id"], name: "index_exercises_on_exercise_type_id"
    t.index ["group_id"], name: "index_exercises_on_group_id"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_members_on_group_id"
    t.index ["user_id"], name: "index_group_members_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "created_by_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_user_id"], name: "index_groups_on_created_by_user_id"
  end

  create_table "routine_exercises", force: :cascade do |t|
    t.text "note"
    t.integer "sets"
    t.integer "routine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exercise_id"
    t.index ["exercise_id"], name: "index_routine_exercises_on_exercise_id"
    t.index ["routine_id"], name: "index_routine_exercises_on_routine_id"
  end

  create_table "routines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["group_id"], name: "index_routines_on_group_id"
    t.index ["user_id"], name: "index_routines_on_user_id"
  end

  create_table "session_exercises", force: :cascade do |t|
    t.integer "routine_exercise_id", null: false
    t.integer "workout_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exercise_id", null: false
    t.integer "sets"
    t.integer "reps"
    t.decimal "weight"
    t.text "note"
    t.json "set_details"
    t.index ["exercise_id"], name: "index_session_exercises_on_exercise_id"
    t.index ["routine_exercise_id"], name: "index_session_exercises_on_routine_exercise_id"
    t.index ["workout_session_id"], name: "index_session_exercises_on_workout_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal "bodyweight"
    t.text "notes"
    t.integer "routine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.index ["group_id"], name: "index_sessions_on_group_id"
    t.index ["routine_id"], name: "index_sessions_on_routine_id"
    t.index ["user_id"], name: "index_sessions_on_user_id"
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

  create_table "workout_exercises", force: :cascade do |t|
    t.integer "workout_session_id", null: false
    t.integer "exercise_id", null: false
    t.integer "sets"
    t.integer "reps"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_exercises_on_exercise_id"
    t.index ["workout_session_id"], name: "index_workout_exercises_on_workout_session_id"
  end

  create_table "workout_routines", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "user_id", null: false
    t.integer "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_routines_on_user_id"
    t.index ["workspace_id"], name: "index_workout_routines_on_workspace_id"
  end

  create_table "workout_sessions", force: :cascade do |t|
    t.integer "routine_id", null: false
    t.integer "user_id", null: false
    t.date "date"
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["group_id"], name: "index_workout_sessions_on_group_id"
    t.index ["routine_id"], name: "index_workout_sessions_on_routine_id"
    t.index ["user_id"], name: "index_workout_sessions_on_user_id"
  end

  add_foreign_key "categories", "groups"
  add_foreign_key "exercises", "categories"
  add_foreign_key "exercises", "exercise_types"
  add_foreign_key "exercises", "groups"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "groups", "users", column: "created_by_user_id"
  add_foreign_key "routine_exercises", "exercises"
  add_foreign_key "routine_exercises", "routines"
  add_foreign_key "routines", "groups"
  add_foreign_key "routines", "users"
  add_foreign_key "session_exercises", "exercises"
  add_foreign_key "session_exercises", "sessions", column: "workout_session_id"
  add_foreign_key "sessions", "groups"
  add_foreign_key "sessions", "routines"
  add_foreign_key "sessions", "users"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_exercises", "workout_sessions"
  add_foreign_key "workout_routines", "groups", column: "workspace_id"
  add_foreign_key "workout_routines", "users"
  add_foreign_key "workout_sessions", "groups"
  add_foreign_key "workout_sessions", "groups"
  add_foreign_key "workout_sessions", "routines"
  add_foreign_key "workout_sessions", "users"
  add_foreign_key "workout_sessions", "users"
end
