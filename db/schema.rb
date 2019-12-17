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

ActiveRecord::Schema.define(version: 2019_12_17_022348) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "age"
    t.string "bio"
    t.integer "project_id"
  end

  create_table "days", force: :cascade do |t|
    t.datetime "date"
  end

  create_table "posts", force: :cascade do |t|
    t.string "name"
    t.integer "day_id"
    t.text "content"
    t.text "link"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "bio"
    t.string "artform"
    t.string "genre"
    t.integer "user_id"
  end

  create_table "scenes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "project_id"
    t.integer "order"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.text "email"
  end

end
