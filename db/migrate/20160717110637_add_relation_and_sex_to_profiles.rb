class AddRelationAndSexToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :sex, :string
    add_column :profiles, :relation, :string
  end
end
