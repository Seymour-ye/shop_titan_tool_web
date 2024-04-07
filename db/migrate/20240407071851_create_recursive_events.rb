class CreateRecursiveEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :recursive_events do |t|
      t.string :name
      t.string :category
      t.datetime :start_time
      t.integer :duration
      t.string :recurrence
      t.string :icon_url

      t.timestamps
    end
  end
end
