class CreateQaCustoms < ActiveRecord::Migration[5.0]
  def change
    create_table :qa_customs do |t|
      t.text :question
      t.text :answer
      t.integer :loves, default: 0
      t.integer :friendship_id

      t.timestamps
    end
    add_index :qa_customs, :friendship_id
  end
end
