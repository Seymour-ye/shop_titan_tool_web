class CreateBlueprints < ActiveRecord::Migration[7.0]
  # any upgrades are not yet added
  def change
    create_table :blueprints do |t|
      t.string :blueprint_id
      t.string :name_en
      t.string :name_zh
      t.string :category
      t.string :unlock_prerequisite
      t.integer :research_scrolls
      t.integer :antique_tokens
      t.integer :tier
      t.integer :value
      t.integer :crafting_time
      t.integer :merchant_xp
      t.integer :worker_xp
      t.integer :fusion_xp
      t.integer :favor
      t.integer :airship_power

      t.jsonb :workers, default: {}

      t.integer :iron
      t.integer :wood
      t.integer :leather
      t.integer :herbs
      t.integer :steel
      t.integer :ironwood
      t.integer :fabric
      t.integer :oil
      t.integer :jewels
      t.integer :ether
      t.integer :essence

      t.jsonb :components, default: {}

      t.integer :attack
      t.integer :defence
      t.integer :health
      t.integer :evasion
      t.integer :critical_hit_chance

      t.string :elemental_affinity
      t.string :spirit_affinity

      t.integer :surcharge_energy
      t.integer :discount_energy
      t.integer :suggest_energy
      t.integer :speedup_energy

      t.date :released_date

      t.timestamps
    end
  end
end
