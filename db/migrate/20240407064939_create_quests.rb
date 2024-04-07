class CreateQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :quests do |t|
      t.string :region
      t.string :reward_type, array: true
      t.integer :max_party_size
      t.bigint :unlock_cost_gold
      t.integer :unlock_cost_gem
      t.integer :unlock_level_merchant

      t.string :difficulty
      t.string :target
      t.integer :min_power
      t.integer :quest_time
      t.integer :rest_time
      t.integer :heal_time

      t.jsonb :components
      
      t.integer :min_item
      t.integer :max_item 

      t.integer :monster_health
      t.integer :monster_dmg
      t.integer :monster_aoe

      t.string :barrier_type
      t.integer :barrier_health
    end
  end
end
