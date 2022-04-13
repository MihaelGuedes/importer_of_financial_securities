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

ActiveRecord::Schema[7.0].define(version: 2022_04_09_202945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "title_criticisms", force: :cascade do |t|
    t.text "assignors_protests"
    t.text "drawees_protests"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "title_id", null: false
    t.index ["title_id"], name: "index_title_criticisms_on_title_id"
  end

  create_table "titles", force: :cascade do |t|
    t.string "title_number"
    t.decimal "value"
    t.string "due_date"
    t.string "cnpj_assignor"
    t.string "cnpj_drawee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "title_criticisms", "titles"
end
