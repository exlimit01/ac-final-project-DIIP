class AddBasicUserInfoToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :nickname, :string
    add_column :profiles, :age, :integer, default: 18
    add_column :profiles, :description, :text
    add_column :profiles, :facebook_link, :string
    add_column :profiles, :facebook_access_level, :integer, default: 0
    add_column :profiles, :line_account, :string
    add_column :profiles, :line_access_level, :integer, default: 0
    add_column :profiles, :wechat_account, :string
    add_column :profiles, :wechat_access_level, :integer, default: 0
  end
end
