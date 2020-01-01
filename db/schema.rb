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

ActiveRecord::Schema.define(version: 2019_12_30_085818) do

  create_table "games", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "guest_team_id"
    t.integer "host_team_id"
    t.string "name"
    t.integer "game_type"
    t.boolean "played", default: false, null: false
    t.integer "guest_team_result"
    t.integer "host_team_result"
    t.integer "playoff_level"
    t.integer "division"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "host_team_points"
    t.integer "guest_team_points"
    t.index ["guest_team_id"], name: "index_games_on_guest_team_id"
    t.index ["host_team_id"], name: "index_games_on_host_team_id"
    t.index ["name"], name: "index_games_on_name"
    t.index ["tournament_id", "guest_team_id", "host_team_id", "playoff_level"], name: "unique_game_among_tournament_index", unique: true
    t.index ["tournament_id"], name: "index_games_on_tournament_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "tournament_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "division"
    t.integer "total_points", default: 0, null: false
    t.integer "total_goals", default: 0, null: false
    t.index ["team_id"], name: "index_tournament_entries_on_team_id"
    t.index ["tournament_id", "team_id"], name: "index_tournament_entries_on_tournament_id_and_team_id", unique: true
    t.index ["tournament_id"], name: "index_tournament_entries_on_tournament_id"
  end

  create_table "tournaments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tournaments_on_name", unique: true
  end

  add_foreign_key "tournament_entries", "teams"
  add_foreign_key "tournament_entries", "tournaments"
end
