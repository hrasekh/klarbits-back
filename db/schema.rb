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

ActiveRecord::Schema[7.2].define(version: 2025_03_01_091845) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_translations", force: :cascade do |t|
    t.bigint "answer_id", null: false
    t.string "locale", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id", "locale"], name: "index_answer_translations_on_answer_id_and_locale", unique: true
    t.index ["answer_id"], name: "index_answer_translations_on_answer_id"
  end

  create_table "answers", force: :cascade do |t|
    t.text "answer", null: false
    t.bigint "question_id", null: false
    t.boolean "is_correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "question_translations", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "locale", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id", "locale"], name: "index_question_translations_on_question_id_and_locale", unique: true
    t.index ["question_id"], name: "index_question_translations_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.text "question", null: false
    t.uuid "uuid", null: false
    t.bigint "category_id", null: false
    t.bigint "subcategory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
    t.index ["subcategory_id"], name: "index_questions_on_subcategory_id"
    t.index ["uuid"], name: "index_questions_on_uuid", unique: true
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
    t.index ["slug"], name: "index_subcategories_on_slug", unique: true
  end

  add_foreign_key "answer_translations", "answers"
  add_foreign_key "answers", "questions"
  add_foreign_key "question_translations", "questions"
  add_foreign_key "questions", "categories"
  add_foreign_key "questions", "subcategories"
  add_foreign_key "subcategories", "categories"
end
