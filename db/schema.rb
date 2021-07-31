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

ActiveRecord::Schema.define(version: 2021_07_31_193738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_events_on_name"
    t.index ["start_at"], name: "index_events_on_start_at", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_games_on_event_id"
  end

  create_table "role_definitions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_role_definitions_on_name", unique: true
  end

  create_table "sheet_definitions", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "role_definition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "role_definition_id"], name: "index_sheet_definitions_on_name_and_role_definition_id", unique: true
    t.index ["name"], name: "index_sheet_definitions_on_name", unique: true
    t.index ["role_definition_id"], name: "index_sheet_definitions_on_role_definition_id"
  end

  create_table "sheets", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "sheet_definition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sheet_definition_id"], name: "index_sheets_on_sheet_definition_id"
    t.index ["team_id", "sheet_definition_id"], name: "index_sheets_on_team_id_and_sheet_definition_id", unique: true
    t.index ["team_id"], name: "index_sheets_on_team_id"
  end

  create_table "team_definitions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_team_definitions_on_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "team_definition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id", "team_definition_id"], name: "index_teams_on_game_id_and_team_definition_id", unique: true
    t.index ["game_id"], name: "index_teams_on_game_id"
    t.index ["team_definition_id"], name: "index_teams_on_team_definition_id"
  end

  add_foreign_key "games", "events"
  add_foreign_key "sheet_definitions", "role_definitions"
  add_foreign_key "sheets", "sheet_definitions"
  add_foreign_key "sheets", "teams"
  add_foreign_key "teams", "games"
  add_foreign_key "teams", "team_definitions"
end
