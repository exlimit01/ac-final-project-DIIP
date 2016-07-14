class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|

      t.attachment :photo
      t.integer :profile_id, :index => true

      t.timestamps
    end
  end
end