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

ActiveRecord::Schema.define(version: 20150126114156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.string   "skill"
    t.integer  "gender"
    t.decimal  "experience",          precision: 5, scale: 2
    t.integer  "source_id"
    t.integer  "role_id"
    t.datetime "last_interview_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "experience_years",                            default: 0
    t.integer  "experience_months",                           default: 0
    t.text     "notes"
    t.integer  "last_status"
    t.integer  "last_stage_id"
  end

  add_index "candidates", ["last_interview_date"], name: "index_candidates_on_last_interview_date", using: :btree
  add_index "candidates", ["last_stage_id"], name: "index_candidates_on_last_stage_id", using: :btree
  add_index "candidates", ["role_id"], name: "index_candidates_on_role_id", using: :btree
  add_index "candidates", ["source_id"], name: "index_candidates_on_source_id", using: :btree

  create_table "employee_interviews", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "interview_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employee_interviews", ["employee_id"], name: "index_employee_interviews_on_employee_id", using: :btree
  add_index "employee_interviews", ["interview_id"], name: "index_employee_interviews_on_interview_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "employee_ref"
    t.integer  "grade_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inactive",     default: false, null: false
  end

  add_index "employees", ["employee_ref"], name: "index_employees_on_employee_ref", using: :btree
  add_index "employees", ["grade_id"], name: "index_employees_on_grade_id", using: :btree
  add_index "employees", ["role_id"], name: "index_employees_on_role_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inactive",   default: false, null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.datetime "interview_date"
    t.integer  "candidate_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.integer  "stage_id"
  end

  add_index "interviews", ["candidate_id"], name: "index_interviews_on_candidate_id", using: :btree
  add_index "interviews", ["stage_id"], name: "index_interviews_on_stage_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inactive",   default: false, null: false
  end

  create_table "source_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: :cascade do |t|
    t.string   "name"
    t.integer  "source_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["source_group_id"], name: "index_sources_on_source_group_id", using: :btree

  create_table "stages", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "points"
  end

  add_foreign_key "employee_interviews", "employees"
  add_foreign_key "employee_interviews", "interviews"
end
