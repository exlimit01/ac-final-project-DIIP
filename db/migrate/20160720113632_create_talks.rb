class CreateTalks < ActiveRecord::Migration[5.0]
  def change
    create_table :talks do |t|
      t.text :content
      t.string :author
      t.integer :room_id

      t.timestamps
    end
    add_index :talks, :room_id
  end
end
