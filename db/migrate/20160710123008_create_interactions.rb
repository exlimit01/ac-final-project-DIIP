class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :interactions do |t|
      t.integer :mission_id
      t.integer :friendship_id
      t.integer :score, default: 0
      t.text :comment

      t.timestamps
    end
    add_index :interactions, :mission_id
    add_index :interactions, :friendship_id

  end
end
