class AddColumnToProfilePictures < ActiveRecord::Migration[5.0]
  def change
    add_column :profile_pictures, :avatar_id, :integer
    add_column :profile_pictures, :user_id, :integer
  end
end
