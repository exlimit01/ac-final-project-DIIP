class AddAboutmeToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :aboutme, :text
  end
end
