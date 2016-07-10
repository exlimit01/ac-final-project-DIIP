class RenameUserIdForHobbyTags < ActiveRecord::Migration[5.0]
  def change
    rename_column :hobby_tags, :user_id, :profile_id
  end
end
