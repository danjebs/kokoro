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

ActiveRecord::Schema[8.0].define(version: 2024_10_30_003832) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "board_status", ["active", "archived"]
  create_enum "invitation_status", ["pending", "accepted", "declined"]
  create_enum "task_status_state", ["inactive", "active", "archived"]

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", enum_type: "board_status"
    t.index ["creator_id"], name: "index_boards_on_creator_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.bigint "user_id", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "collaborateable_type", null: false
    t.bigint "collaborateable_id", null: false
    t.string "email", null: false
    t.bigint "invitee_id"
    t.bigint "inviter_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "status", enum_type: "invitation_status"
    t.index ["collaborateable_type", "collaborateable_id", "email"], name: "index_invitations_on_collaborateable_and_email"
    t.index ["collaborateable_type", "collaborateable_id"], name: "index_invitations_on_collaborateable"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
    t.index ["inviter_id"], name: "index_invitations_on_inviter_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "task_statuses", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.string "name"
    t.integer "position"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_task_statuses_on_board_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.bigint "board_id", null: false
    t.bigint "task_status_id", null: false
    t.bigint "creator_id", null: false
    t.bigint "assignee_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["board_id"], name: "index_tasks_on_board_id"
    t.index ["creator_id"], name: "index_tasks_on_creator_id"
    t.index ["task_status_id"], name: "index_tasks_on_task_status_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "boards", "users", column: "creator_id"
  add_foreign_key "comments", "users"
  add_foreign_key "invitations", "users", column: "invitee_id"
  add_foreign_key "invitations", "users", column: "inviter_id"
  add_foreign_key "task_statuses", "boards"
  add_foreign_key "tasks", "boards"
  add_foreign_key "tasks", "task_statuses"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "creator_id"
end
