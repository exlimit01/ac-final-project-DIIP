class AddLocationIdToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :location_id, :integer
    add_index :profiles, :location_id
  end

end
