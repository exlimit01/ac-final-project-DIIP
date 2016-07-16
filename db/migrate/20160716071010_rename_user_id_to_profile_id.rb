class RenameUserIdToProfileId < ActiveRecord::Migration[5.0]
  def change
    rename_column :answers, :user_id, :profile_id
  end
end
