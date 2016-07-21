class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :user_id1
      t.integer :user_id2
      t.integer :interaction_id1
      t.integer :interaction_id2
      t.integer :mission_id

      t.timestamps
    end
    add_column :interactions, :room_id, :integer
    add_index :interactions, :room_id
  end
end
