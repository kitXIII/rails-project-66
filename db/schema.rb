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

ActiveRecord::Schema[7.1].define(version: 2024_05_21_183701) do
  create_table "repositories", force: :cascade do |t|
    t.string "name"
    t.integer "github_id", null: false
    t.string "full_name"
    t.string "language"
    t.string "clone_url"
    t.string "ssh_url"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_id"], name: "index_repositories_on_github_id", unique: true
    t.index ["user_id"], name: "index_repositories_on_user_id"
  end

  create_table "repository_check_files", force: :cascade do |t|
    t.string "path"
    t.integer "check_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_repository_check_files_on_check_id"
  end

  create_table "repository_check_flaws", force: :cascade do |t|
    t.string "rule"
    t.text "message"
    t.string "location"
    t.integer "check_id", null: false
    t.integer "file_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_repository_check_flaws_on_check_id"
    t.index ["file_id"], name: "index_repository_check_flaws_on_file_id"
  end

  create_table "repository_checks", force: :cascade do |t|
    t.string "commit_id"
    t.integer "repository_id", null: false
    t.string "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id"], name: "index_repository_checks_on_repository_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "nickname"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "repositories", "users"
  add_foreign_key "repository_check_files", "repository_checks", column: "check_id"
  add_foreign_key "repository_check_flaws", "repository_check_files", column: "file_id"
  add_foreign_key "repository_check_flaws", "repository_checks", column: "check_id"
  add_foreign_key "repository_checks", "repositories"
end
