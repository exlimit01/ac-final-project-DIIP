class CreateProfessionTags < ActiveRecord::Migration[5.0]
  def change
    create_table :profession_tags do |t|
      t.integer :user_id
      t.integer :profession_id

      t.timestamps
    end
    add_index :profession_tags, :user_id
    add_index :profession_tags, :profession_id
  end
end
