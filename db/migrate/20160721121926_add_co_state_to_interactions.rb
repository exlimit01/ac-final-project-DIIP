class AddCoStateToInteractions < ActiveRecord::Migration[5.0]
  def change
    add_column :interactions, :co_status, :integer, default: 0
  end
end
