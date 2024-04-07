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

ActiveRecord::Schema[7.0].define(version: 2024_04_07_060828) do
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

end
