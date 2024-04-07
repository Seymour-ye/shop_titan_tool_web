class CreateWorkerLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :worker_levels do |t|
      t.integer :worker_level
      t.integer :xp_needed
      t.decimal :crafting_speed_bonus

      t.timestamps
    end
  end
end
