class CreateWorkers < ActiveRecord::Migration[7.0]
  # Blueprints unlocked by worker not added
  def change
    create_table :workers do |t|
      t.string :name
      t.string :worker_category
      t.string :building
      t.integer :unlock_merchant_level
      t.integer :gold_cost
      t.integer :gem_cost

      t.timestamps
    end
  end
end
