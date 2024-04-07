class CreateComponents < ActiveRecord::Migration[7.0]
  def change
    create_table :components do |t|
      t.string :name
      t.string :category
      t.integer :tier
      t.integer :value
      t.string :get_from

      t.timestamps
    end
  end
end
