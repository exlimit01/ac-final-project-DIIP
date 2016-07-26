class AddColumnToAvatar < ActiveRecord::Migration[5.0]
  def change
    add_column :avatars, :filename, :string
  end
end
