class CreateHobbyTags < ActiveRecord::Migration[5.0]
  def change
    create_table :hobby_tags do |t|
      t.integer :user_id
      t.integer :hobby_id

      t.timestamps
    end
    add_index :hobby_tags, :user_id
    add_index :hobby_tags, :hobby_id
  end
end
