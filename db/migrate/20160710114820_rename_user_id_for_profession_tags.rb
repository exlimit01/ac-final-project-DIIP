class RenameUserIdForProfessionTags < ActiveRecord::Migration[5.0]
  def change
    rename_column :profession_tags, :user_id, :profile_id
  end
end
