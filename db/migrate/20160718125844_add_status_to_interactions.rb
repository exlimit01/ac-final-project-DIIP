class AddStatusToInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :interactions, :status, :string, default: "request"
  end
end
