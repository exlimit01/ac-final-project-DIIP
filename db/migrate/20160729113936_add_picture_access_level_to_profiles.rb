class AddPictureAccessLevelToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :picture_access_level, :integer, default: 30
    change_column :profiles, :facebook_access_level, :integer, :default => 30
    change_column :profiles, :line_access_level, :integer, :default => 30
    change_column :profiles, :wechat_access_level, :integer, :default => 30
  end
end
