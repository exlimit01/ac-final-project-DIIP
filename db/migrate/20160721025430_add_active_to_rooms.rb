class AddActiveToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :active, :boolean, default: true
  end
end
