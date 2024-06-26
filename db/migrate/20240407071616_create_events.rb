class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :category
      t.datetime :start_time
      t.datetime :end_time
      t.string :icon_url

      t.timestamps
    end
  end
end
