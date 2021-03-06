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

ActiveRecord::Schema.define(version: 2021_08_01_101551) do

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

  create_table "instant_entries", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_instant_entries_on_event_id"
    t.index ["name", "event_id"], name: "index_instant_entries_on_name_and_event_id", unique: true
    t.index ["name"], name: "index_instant_entries_on_name"
  end

  create_table "instant_game_entries", force: :cascade do |t|
    t.bigint "instant_entry_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_instant_game_entries_on_game_id"
    t.index ["instant_entry_id", "game_id"], name: "index_instant_game_entries_on_instant_entry_id_and_game_id", unique: true
    t.index ["instant_entry_id"], name: "index_instant_game_entries_on_instant_entry_id"
  end

  create_table "instant_role_requests", force: :cascade do |t|
    t.bigint "instant_entry_id", null: false
    t.bigint "role_definition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instant_entry_id", "role_definition_id"], name: "index_instant_role_requests_on_entry_id_and_role_id", unique: true
    t.index ["instant_entry_id"], name: "index_instant_role_requests_on_instant_entry_id"
    t.index ["role_definition_id"], name: "index_instant_role_requests_on_role_definition_id"
  end

  create_table "instant_seat_assignments", force: :cascade do |t|
    t.bigint "instant_game_entry_id", null: false
    t.bigint "seat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["instant_game_entry_id"], name: "index_instant_seat_assignments_on_instant_game_entry_id", unique: true
    t.index ["seat_id"], name: "index_instant_seat_assignments_on_seat_id", unique: true
  end

  create_table "role_definitions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_role_definitions_on_name", unique: true
  end

  create_table "seat_definitions", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "role_definition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "role_definition_id"], name: "index_seat_definitions_on_name_and_role_definition_id", unique: true
    t.index ["name"], name: "index_seat_definitions_on_name", unique: true
    t.index ["role_definition_id"], name: "index_seat_definitions_on_role_definition_id"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "seat_definition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seat_definition_id"], name: "index_seats_on_seat_definition_id"
    t.index ["team_id", "seat_definition_id"], name: "index_seats_on_team_id_and_seat_definition_id", unique: true
    t.index ["team_id"], name: "index_seats_on_team_id"
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
  add_foreign_key "instant_entries", "events"
  add_foreign_key "instant_game_entries", "games"
  add_foreign_key "instant_game_entries", "instant_entries"
  add_foreign_key "instant_role_requests", "instant_entries"
  add_foreign_key "instant_role_requests", "role_definitions"
  add_foreign_key "instant_seat_assignments", "instant_game_entries"
  add_foreign_key "instant_seat_assignments", "seats"
  add_foreign_key "seat_definitions", "role_definitions"
  add_foreign_key "seats", "seat_definitions"
  add_foreign_key "seats", "teams"
  add_foreign_key "teams", "games"
  add_foreign_key "teams", "team_definitions"
end
