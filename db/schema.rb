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

ActiveRecord::Schema[7.0].define(version: 2024_04_07_081147) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blueprints", force: :cascade do |t|
    t.string "blueprint_id"
    t.string "name_en"
    t.string "name_zh"
    t.string "category"
    t.string "unlock_prerequisite"
    t.integer "research_scrolls"
    t.integer "antique_tokens"
    t.integer "tier"
    t.integer "value"
    t.integer "crafting_time"
    t.integer "merchant_xp"
    t.integer "worker_xp"
    t.integer "fusion_xp"
    t.integer "favor"
    t.integer "airship_power"
    t.jsonb "workers", default: {}
    t.integer "iron"
    t.integer "wood"
    t.integer "leather"
    t.integer "herbs"
    t.integer "steel"
    t.integer "ironwood"
    t.integer "fabric"
    t.integer "oil"
    t.integer "jewels"
    t.integer "ether"
    t.integer "essence"
    t.jsonb "components", default: {}
    t.integer "attack"
    t.integer "defence"
    t.integer "health"
    t.integer "evasion"
    t.integer "critical_hit_chance"
    t.string "elemental_affinity"
    t.string "spirit_affinity"
    t.integer "surcharge_energy"
    t.integer "discount_energy"
    t.integer "suggest_energy"
    t.integer "speedup_energy"
    t.date "released_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "tier"
    t.integer "value"
    t.string "get_from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "icon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flash_quests", force: :cascade do |t|
    t.integer "day_of_month"
    t.integer "unlock_merchant_level"
    t.string "name"
    t.string "rewards"
    t.string "reward_icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string "region"
    t.string "reward_type", array: true
    t.integer "max_party_size"
    t.bigint "unlock_cost_gold"
    t.integer "unlock_cost_gem"
    t.integer "unlock_level_merchant"
    t.string "difficulty"
    t.string "target"
    t.integer "min_power"
    t.integer "quest_time"
    t.integer "rest_time"
    t.integer "heal_time"
    t.jsonb "components"
    t.integer "min_item"
    t.integer "max_item"
    t.integer "monster_health"
    t.integer "monster_dmg"
    t.integer "monster_aoe"
    t.string "barrier_type"
    t.integer "barrier_health"
  end

  create_table "recursive_events", force: :cascade do |t|
    t.string "name"
    t.datetime "start_time"
    t.integer "duration"
    t.string "recurrence"
    t.string "icon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worker_levels", force: :cascade do |t|
    t.integer "worker_level"
    t.integer "xp_needed"
    t.decimal "crafting_speed_bonus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.string "worker_category"
    t.string "building"
    t.integer "unlock_merchant_level"
    t.integer "gold_cost"
    t.integer "gem_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
