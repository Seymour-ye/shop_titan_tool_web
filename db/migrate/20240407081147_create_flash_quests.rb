class CreateFlashQuests < ActiveRecord::Migration[7.0]
  def change
    create_table :flash_quests do |t|
      t.integer :day_of_month 
      t.integer :unlock_merchant_level
      t.string :name 
      t.string :rewards 
      t.string :reward_icon

      t.timestamps
    end
  end
end
