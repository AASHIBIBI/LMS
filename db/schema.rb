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

ActiveRecord::Schema.define(version: 2025_05_24_191801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_bookmarks_on_book_id"
    t.index ["student_id"], name: "index_bookmarks_on_student_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.text "language"
    t.text "published"
    t.text "edition"
    t.text "image"
    t.text "subject"
    t.text "summary"
    t.boolean "special"
    t.integer "count"
    t.bigint "library_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_id"], name: "index_books_on_library_id"
  end

  create_table "checkouts", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "book_id"
    t.date "issue_date"
    t.date "return_date"
    t.integer "validity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_checkouts_on_book_id"
    t.index ["student_id"], name: "index_checkouts_on_student_id"
  end

  create_table "hold_requests", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_hold_requests_on_book_id"
    t.index ["student_id"], name: "index_hold_requests_on_student_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "library"
    t.string "university"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_librarians_on_email", unique: true
    t.index ["reset_password_token"], name: "index_librarians_on_reset_password_token", unique: true
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.string "location"
    t.integer "max_days"
    t.decimal "overdue_fines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_books", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_special_books_on_book_id"
    t.index ["student_id"], name: "index_special_books_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "education_level"
    t.string "university"
    t.integer "max_book_allowed"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.string "google_token"
    t.string "google_refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.bigint "student_id"
    t.bigint "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_transactions_on_book_id"
    t.index ["student_id"], name: "index_transactions_on_student_id"
  end

  add_foreign_key "bookmarks", "books"
  add_foreign_key "bookmarks", "students"
  add_foreign_key "books", "libraries"
  add_foreign_key "checkouts", "books"
  add_foreign_key "checkouts", "students"
  add_foreign_key "hold_requests", "books"
  add_foreign_key "hold_requests", "students"
  add_foreign_key "special_books", "books"
  add_foreign_key "special_books", "students"
  add_foreign_key "transactions", "books"
  add_foreign_key "transactions", "students"
end
